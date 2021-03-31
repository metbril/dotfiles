#!/usr/bin/env bash

# Author: Dmitri Popov, dmpop@linux.com
# License: GPLv3 https://www.gnu.org/licenses/gpl-3.0.txt
# Source code: https://github.com/dmpop/photo-funnel

# brew install jq

PREFS="$HOME/.pf"

check1=$(curl --silent http://photon.komoot.de/)
if [ -z "$check1" ]; then
  echo "Photon is not reachable. Check your Internet connection."
  exit 1
fi

if [ ! -f "$PREFS" ]; then
  echo "Select destination directory"
  read dir
  echo "Copyright notice:"
  read copyright
  echo 'dir="'$dir'"' >> "$PREFS"
  echo 'copyright="'$copyright'"' >> "$PREFS"
  echo 'json="$HOME/weather.json"' >> "$PREFS"
  echo "Provide Dark Sky API key and press [ENTER]"
  read api_key
  echo 'api_key="'$api_key'"' >> "$PREFS"
fi
source "$PREFS"

f=$@

echo "Enter city and press [ENTER]:"
read city

if [ ! -z "$f" ]; then
  if [ ! -d "$dir" ]; then
    mkdir "$dir"
  fi
  cp "$f" "$dir"
  cd "$dir"
  
    if [ ! -z "$city" ]; then

    lat=$(curl "photon.komoot.de/api/?q=$city" | jq '.features | .[0] | .geometry | .coordinates | .[1]')
      if (( $(echo "$lat > 0" |bc -l) )); then
        latref="N"
      else
        latref="S"
      fi

    lon=$(curl "photon.komoot.de/api/?q=$city" | jq '.features | .[0] | .geometry | .coordinates | .[0]')
      if (( $(echo "$lon > 0" |bc -l) )); then
        lonref="E"
      else
        lonref="W"
      fi

      exiftool -overwrite_original -copyright="$copyright" -GPSLatitude=$lat -GPSLatitudeRef=$latref -GPSLongitude=$lon -GPSLongitudeRef=$lonref -ext JPG .

      check2=$(wget -q --spider https://api.darksky.net/)
      if [ -z $check2 ]; then
	  for file in *.JPG
	  do
	      t=$(exiftool -d %Y-%m-%d -DateTimeOriginal $file | cut -d":" -f2 | tr -d " " | xargs -I dt date --date=dt +"%s")
	      camera=$(exiftool -Model $file | cut -d":" -f2 | tr -d " ")
	      lens=$(exiftool -LensID $file | cut -d":" -f2)
	      curl "https://api.darksky.net/forecast/"$api_key"/"$lat","$lon","$t"?units=si&exclude=currently,hourly,flags" > $json
	      w_sum=$(jq '.daily | .data | .[0] | .summary' $json | tr -d '"')
	      w_temp=$(jq '.daily | .data | .[0] | .temperatureHigh' $json | tr -d '"')
	      exiftool -overwrite_original -comment="$camera, $lens, $w_temp°C, $w_sum" $file
	  done
      fi
    fi
  
  exiftool -d %Y%m%d-%H%M%S%%-c.%%e '-FileName<DateTimeOriginal' .
  exiftool '-Directory<CreateDate' -d ./%Y-%m-%d .
  rm $json
  yad --skip-taskbar --button=gtk-close:0 --center \
      --text="<big>Import completed. Bye!</big>"
else
  yad --skip-taskbar --undecorated --borders=75 \
      --timeout=3 --no-buttons --center \
      --text="<big>Nothing to do. Bye!</big>"
exit 1
fi
