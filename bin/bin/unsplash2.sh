#!/usr/bin/bash

# Configuration:
CLIENT_ID=YOUR_APPLICATION_ID_FROM_UNSPLASH_HERE
OUT=~/Pictures/Backgrounds/unsplash.jpg

# Auto-detected Configuration and constants:
if hash system_profiler 2>/dev/null; then   # Mac                                                   
    WIDTH=$(system_profiler SPDisplaysDataType | grep Resolution | awk '{print $2}')                
    HEIGHT=$(system_profiler SPDisplaysDataType | grep Resolution | awk '{print $4}')               
else    # Linux                                                                                     
    WIDTH=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)                 
    HEIGHT=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)                
fi
URL="https://api.unsplash.com/photos/random?featured=1&amp;w=$WIDTH&amp;h=$HEIGHT&amp;client_id=$CLIENT_ID"
TMP=/tmp/unsplash

# Request a random photo, and parse out some details from the resulting JSON using Perl (sort of a
# hack, but avoids adding dependencies.)
JSON=$(curl -vs $URL 2>/dev/null)
IMG=$(echo $JSON | perl -pe 's|.*"custom":"(.*?)".*|\1|')
NAME=$(echo $JSON | perl -pe 's|.*"name":"(.*?)".*|\1|')

# Download and, if successful, process the resulting photo
wget "$IMG" -O "$TMP" >/dev/null 2>&amp;1
if [ $? -eq 0 ]; then
    if hash convert 2>/dev/null; then
        convert $TMP  -fill white  -undercolor '#00000080'  -gravity SouthEast -annotate +0+5 \
                " $NAME " $OUT
    else
        mv $TMP $OUT
    fi
fi

# Update the final background
if hash convert 2>/dev/null; then   # Linux
    hsetroot -fill $OUT
elif hash osascript 2>/dev/null; then    # Mac
    osascript -e "tell application 'Finder' to set desktop picture to POSIX file '$OUT'" 
fi