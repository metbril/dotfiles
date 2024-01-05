#!/usr/bin/env bash

# This script parses all bank statements that are downloaded from the bank website.
# The downloads are done per calendar year and are concatenated for Memacs.

## TODO: Allow spaces in path to CSV_FILES

MYHOME=/Users/robert
# CSV_FILES=$MYHOME/Desktop/Afschriften/*.csv
CSV_FILES=$MYHOME/Sync/Documenten/Administratie/B15_Huishouden/10-19_Financien/11_Geldzaken/11.01_ING_Betaalrekening/Afschriften/*.csv
ORG_FILE=$MYHOME/org/memacs/ingbank.org_archive
MEMACS=/opt/homebrew/bin/memacs_csv

mv $ORG_FILE ${ORG_FILE}.bak

for file in $CSV_FILES
do
	$MEMACS --file "${file}" \
	  --timestamp-field "datum" \
	  --timestamp-format "%Y%m%d" \
	  --output-format "{naam / omschrijving} {af bij} {bedrag (eur)}" \
	  --properties "af bij,bedrag (eur),code,mededelingen,mutatiesoort,tegenrekening" \
	  --append \
	  --output $ORG_FILE
done
