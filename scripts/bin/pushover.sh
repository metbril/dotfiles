#!/usr/bin/env bash

echo $#
echo $*
echo

curl -s \
  --form-string "token=$PUSHOVER_API_TOKEN" \
  --form-string "user=$PUSHOVER_USER_KEY" \
  --form-string "message=`echo -e $*`" \
  https://api.pushover.net/1/messages.json
