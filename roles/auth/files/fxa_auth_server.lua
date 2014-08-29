-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "cjson"
require "lpeg"
require "string"
local clf = require "common_log_format"
local dt = require "date_time"
local util = require "util"

local msg = {
    Timestamp = nil,
    Type = nil,
    Hostname = nil,
    Pid = nil,
    EnvVersion = nil,
    Fields = nil
}

function process_message()
    json = cjson.decode(read_message("Payload"))
    if not json then return -1 end

    local ts = lpeg.match(dt.rfc3339, json.time)
    if not ts then return -1 end

    msg.Timestamp = dt.time_to_ns(ts)
    json.time = nil

    if json.op then
        msg.Type = json.op
        json.op = nil
    else
        msg.Type = "unknown"
    end

    msg.Hostname = json.hostname
    json.hostname = nil

    msg.Pid = json.pid
    json.pid = nil

    msg.EnvVersion = json.v
    json.v = nil

    if json.lang then
        json.lang = string.match(json.lang:lower(), "^%a%a")
    end

    if json.agent then
        json.user_agent_browser,
        json.user_agent_version,
        json.user_agent_os = clf.normalize_user_agent(json.agent)
        json.agent = nil
    end

    if type(json.err) == "table" then
        util.table_to_fields(json.err, json, "err")
        json.err = nil
    end

    msg.Fields = json
    if not pcall(inject_message, msg) then return -1 end

    return 0
end
