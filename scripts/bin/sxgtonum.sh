#!/bin/sh

# sxgtonum.sh
# https://gist.github.com/singpolyma/338295
# Implementation of http://tantek.pbworks.com/NewBase60
# License: http://creativecommons.org/licenses/by-sa/3.0/

ord() {
	echo "$1" | od -tu2 -N1 | head -n1 | awk '{ print $2 }'
}

s="$1"
n=0
j="$((`echo "$s" | wc -c` - 1))"
for i in `seq "$j"`; do # iterate from first to last char of $s
	c="$(ord `echo "$s" | cut -c"$i"`)" # put current ASCII of char into $c
	if [ $c -ge 48 -a $c -le 57 ]; then
		c=$(($c - 48))
	elif [ $c -ge 65 -a $c -le 72 ]; then
		c=$(($c - 55))
	elif [ $c = 73 -o $c = 108 ]; then # typo capital I, lowercase l to 1
		c=1
	elif [ $c -ge 74 -a $c -le 78 ]; then
		c=$(($c - 56))
	elif [ $c = 79 ]; then # error correct typo capital O to 0
		c=0
	elif [ $c -ge 80 -a $c -le 90 ]; then
		c=$(($c - 57))
	elif [ $c = 95 ]; then # underscore
		c=34
	elif [ $c -ge 97 -a $c -le 107 ]; then
		c=$(($c - 62))
	elif [ $c -ge 109 -a $c -le 122 ]; then
		c=$(($c - 63))
	else # treat all other noise as 0
		c=0
	fi
	n=$(( $((60 * $n)) + $c ))
done

echo "$n"