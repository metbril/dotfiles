#!/bin/bash

for f in "$@"
do
    # show
    SetFile -a e "$f"
done

