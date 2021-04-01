#!/bin/bash

for f in "$@"
do
    /usr/local/bin/exiftool \
      '-DateTimeOriginal<Filename' \
      -overwrite_original \
      "$f"
done
