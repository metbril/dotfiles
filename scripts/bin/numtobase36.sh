#!/bin/bash
# takes unix timestamp and converts to base36
# ht: https://en.wikipedia.org/wiki/Base36#bash_implementation
# https://en.wikipedia.org/w/index.php?title=Base36&oldid=680300387

value=$1
result=""
base36="0123456789abcdefghijklmnopqrstuvwxyz"
while true; do
	result=${base36:((value%36)):1}${result}
	if [ $((value=${value}/36)) -eq 0 ]; then
		break
	fi
done
echo ${result}