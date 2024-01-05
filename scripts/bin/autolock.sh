#!/bin/sh
# Script to automatically lock and unlock the computer when my usb pendrive is removed
# http://askubuntu.com/questions/28836/lock-and-unlock-from-usb-disk-pendrive
LSUSB=`which lsusb`

if [ -z $LSUSB ]; then
    echo "No lsusb command found. exiting.. \n"
    exit 56
fi

while :
do
    sleep 3
    echo "Running in loop"
    # Check the USB drive

    USB=`lsusb | grep Logitech`

    if [ -n "${USB}" ] ; then
        echo "USB Device: Transcend found"
        # find and kill any screensaver found.
        gnome-screensaver-command --deactivate
        continue
    fi

    # USB Device Not Found
    # Check if screensaver is running or not
    # if not running then start screensaver
    gnome-screensaver-command --activate

done
