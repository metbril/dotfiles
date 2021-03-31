#!/bin/bash

for f in "$@"
do
    STATUS=`getFileInfo -ae "$f"`
    if [ $STATUS == 0 ];
    then
        # hide
	SetFile -a E "$f"
    else
        SetFile -a e "$f"
    fi
done

