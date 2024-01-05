#!/usr/bin/env bash

# Run on photos with embedded geo-data to get the coordinates and open it in a map
# Credits: https://www.evanlovely.com/utilities/photo-geotags/

lat=$(mdls -raw -name kMDItemLatitude "$1")
if [ "$lat" != "(null)" ]; then
	long=$(mdls -raw -name kMDItemLongitude "$1")
	echo -n $lat,$long | pbcopy
	echo $lat,$long copied
# 	open "https://www.openstreetmap.org/?mlat=$lat&mlon=$long&zoom=16"
# 	open "https://www.google.com/maps?q=$lat,$long"
	open "https://maps.apple.com/?ll=$lat,$long&q=Picture"
else
	echo "No geo-data available"
fi
