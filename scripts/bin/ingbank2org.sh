CSV_FILES=/Users/robert/Sync/Documenten/Administratie/Geldzaken/ING/Betalen/Afschriften/*.csv
ORG_FILE=~/org/memacs/ingbank.org_archive
MEMACS=/opt/homebrew/bin/memacs_csv

rm $ORG_FILE
for file in $CSV_FILES
do
	$MEMACS -f "${file}" \
	  --timestamp-field "datum" \
	  --timestamp-format "%Y%m%d" \
	  --output-format "{naam / omschrijving} {af bij} {bedrag (eur)}" \
	  --append \
	  --output $ORG_FILE
done