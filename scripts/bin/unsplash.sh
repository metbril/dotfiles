#!/bin/bash
# get wallpaper image from unsplash.com

# Tool paths (full path for cron)
SYSPROF=/usr/sbin/system_profiler

#  runs as cronjob, so need full path instead of ~
myplace="/Users/Robert/Pictures/Unsplash/"

# base url
baseurl="https://source.unsplash.com/featured"
keywords="mountain,sunrise"

if hash ${SYSPROF} 2>/dev/null; then   # Mac                                                   
    WIDTH=$(${SYSPROF} SPDisplaysDataType | grep Resolution | awk '{print $2}')                
    HEIGHT=$(${SYSPROF} SPDisplaysDataType | grep Resolution | awk '{print $4}')               
else    # Linux                                                                                     
    WIDTH=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)                 
    HEIGHT=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)                
fi

## Create folder if it not already exists
mkdir -p ${myplace}

## Remove any old image
rm -f ${myplace}unsplash*.jpeg

## get random number to force screensaver update
rnd=`echo $RANDOM`

## Retrieve new image
curl -s -L -o ${myplace}unsplash${rnd}.jpeg "${baseurl}/${WIDTH}x${HEIGHT}/?${keywords}"

#####
## crontab example, every 5 mins

#                 */5 * * * * /Users/robert/bin/unsplash.sh
