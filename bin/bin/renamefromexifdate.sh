#!/bin/bash

for f in "$@"
do
    /usr/local/bin/exiftool '-FileName<CreateDate' -d '%Y-%m-%d-%H%M%S%%-c.%%le' "$f"
done
