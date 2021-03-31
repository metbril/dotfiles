#!/bin/sh

# numtosxg.sh
# https://gist.github.com/singpolyma/338295
# Implementation of http://tantek.pbworks.com/NewBase60
# License: http://creativecommons.org/licenses/by-sa/3.0/

n="$1"
s=''
m='0123456789ABCDEFGHJKLMNPQRSTUVWXYZ_abcdefghijkmnopqrstuvwxyz'
if [ -z "$n" ] || [ "$n" -eq "0" ]; then
	echo 0
	exit
fi

while [ "$n" -gt 0 ]; do
	d="$(($n % 60))"
	s="`echo "$m" | cut -c"$(($d + 1))"`$s"
	n="$(( $(($n - $d)) / 60 ))"
done

echo "$s"