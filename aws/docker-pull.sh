#!/usr/bin/env bash

# Intended for use on the initial build of a box. Ansible will update/restart
# if changed subseqsently.

IMAGES=(
  jrgm/123done
  mozilla/fxa-auth-db-mysql
  mozilla/fxa-auth-server
  mozilla/fxa-basket-proxy
  mozilla/fxa-content-server
  mozilla/fxa-customs-server
  mozilla/fxa-oauth-server
  mozilla/fxa-oauth-console
  mozilla/syncserver
  mozilla/fxa-profile-server
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
