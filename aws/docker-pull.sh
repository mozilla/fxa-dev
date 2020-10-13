#!/usr/bin/env bash

# Intended for use on the initial build of a box. Ansible will update/restart
# if changed subseqsently.

IMAGES=(
  mozilla/channelserver
  mozilla/fxa-email-service
  mozilla/fxa-mono
  mozilla/pushbox
  mozilla/syncserver
  mysql:5.6.35
)

for f in ${IMAGES[*]}; do
  docker pull $f & # run in background
  sleep 0.1        # don't be greedy
done

FAIL=0
for job in `jobs -p`; do
  wait $job || let "FAIL+=1"
done

if [ "$FAIL" == "0" ]; then
  echo Initial docker pull complete: $FAIL
  exit $FAIL
fi

echo Initial docker pull failed: $FAIL
exit $FAIL
