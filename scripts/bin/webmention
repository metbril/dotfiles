#!/bin/bash

your_url=$1
target_url=$2

curl -i -d "source=$your_url&target=$target_url" `curl -i -s $target_url | grep 'rel="http://webmention.org/"' | sed 's/rel="webmention"//' | grep -o -E 'https?://[^ ">]+' | sort | uniq`