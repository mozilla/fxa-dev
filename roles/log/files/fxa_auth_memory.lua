-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "circular_buffer"
require "string"
local alert         = require "alert"
local annotation    = require "annotation"
local anomaly       = require "anomaly"

local static_title      = "Fxa Auth Server"
local rows              = read_config("rows") or 1440
local sec_per_row       = read_config("sec_per_row") or 60
local pid_expiration    = (read_config("pid_expiration") or 600) * 1e9
local HEAP_USED         = 1
local RSS               = 2

pids = {}
last_update = 0

function process_message ()
    local ts    = read_message("Timestamp")
    local host  = read_message("Hostname")
    local pid   = read_message("Pid")
    local hu    = read_message("Fields[heapUsed]")
    local rss   = read_message("Fields[rss]")

    local key = string.format("%s PID:%d", host, pid)
    local p = pids[key]
    if not p then
        p  = circular_buffer.new(rows, 2, sec_per_row)
        p:set_header(HEAP_USED , "heapUsed" , "B", "max")
        p:set_header(RSS       , "rss"      , "B", "max")
        pids[key] = p
    end

    if last_update < ts then
        last_update = ts
    end

    p:set(ts, HEAP_USED , hu)
    p:set(ts, RSS       , rss)
    return 0
end

function timer_event(ns)
    for k, v in pairs(pids) do
        if last_update - v:current_time() < pid_expiration then
            local title = string.format("%s:%s", static_title, k)
            if anomaly_config then
                if not alert.throttled(ns) then
                    local msg, annos = anomaly.detect(ns, static_title, v, anomaly_config)
                    if msg then
                        annotation.concat(k, annos)
                        alert.queue(ns, string.format("%s\n%s", k, msg))
                    end
                end
                output({annotations = annotation.prune(k, ns)}, v)
                inject_message("cbuf", title)
            else
                inject_message(v, title)
            end
        else
            annotation.remove(k)
            pids[k] = nil
        end
    end
    alert.send_queue(ns)
end
