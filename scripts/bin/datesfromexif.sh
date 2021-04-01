#!/bin/bash

for f in "$@"
do
    /usr/local/bin/exiftool \
      '-FileCreateDate<DateTimeOriginal' \
      '-FileModifyDate<DateTimeOriginal' \
      '-FileName<DateTimeOriginal' -d '%Y-%m-%d__%H%M%S%%-c.%%le' \
      "$f"
done
