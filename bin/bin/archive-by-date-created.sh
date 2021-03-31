#!/usr/bin/env bash

for param in "$@"
do
	files=$(ls -lU $param)
	for i in $files; do
				getmonth=$(echo "$i"|awk '{print $7}')
		month=00
		case "$getmonth" in 
			jan) month=01;;
			feb) month=02;;
			mrt) month=03;;
			apr) month=04;;
			mei) month=05;;
			jun) month=06;;
			jul) month=07;;
			aug) month=08;;
			sep) month=09;;
			okt) month=10;;
			nov) month=11;;
			dec) month=12;;
		esac
		getyear=$(echo "$i"|awk '{print $8}')
		if [ $(echo $getyear|awk '{print length}') -lt 5 ]; then
			year=$getyear
		else
			year=$(date "+%Y")
		fi
		echo $year $month $(echo "$i"|awk '{print $9}')

	done
done




# do your business here
