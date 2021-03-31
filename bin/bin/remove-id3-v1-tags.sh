#!/bin/bash
# Script name: remove-id3-v1-tags.sh

# find . -iname "*.mp3" -exec eyeD3 --no-color -v {} \;

find . -iname "*.mp3" \
	-exec eyeD3 -v {} \; \
	-exec eyeD3 --remove-v1 {} \; \
	-exec eyeD3 -v {} \;