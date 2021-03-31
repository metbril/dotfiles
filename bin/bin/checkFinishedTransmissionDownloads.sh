#!/bin/sh

# Script that checks for finished downloads in Transmission and
# sends email to a specified user.
# Author: Alexander Galanin <al@galanin.nnov.ru>
# This code placed into public domain.
# You can download latest version at
# http://galanin.nnov.ru/~al/hg/hgwebdir.cgi/utils/file/tip/checkFinishedTransmissionDownloads.sh

# Requires:
#   GNU mailutils | bsd-mailx (does not work with heirloom-mailx)
#   lockfile-progs
#   transmission-cli

# $Id: checkFinishedTransmissionDownloads.sh,v aa96b17920a4 2010/03/01 12:16:55 al $

############################################################################
# default configuration options
# put it into config file ~/.checkFinishedTransmissionDownloads/config
############################################################################

# HOST=localhost
# PORT=9091

# RPC_AUTH=1
# USER=
# PASS=

# MAILTO=root
# FROM=torrent-checker
# MAIL_CONTENT="Downloading of \"%s\" has been finished.\nGo to %s to make an approriate action.\n"
# ERROR_CONTENT="Error detected in torrent \"%s\": %s.\nGo to %s to make an approriate action.\n"

############################################################################
# CONSTANTS
############################################################################

# ALL_FILE="/tmp/checkFinishedTransmissionDownloads.all"

# TMP_FILE="/tmp/checkFinishedTransmissionDownloads.tmp"
# TMP_FILE2="/tmp/checkFinishedTransmissionDownloads.tmp2"
# LIST_FILE="/tmp/checkFinishedTransmissionDownloads.list"
# LOCK_FILE="/tmp/checkFinishedTransmissionDownloads"

############################################################################
# FUNCTIONS
############################################################################

# Show usage information and exit
usage() {
    echo "$0: check for finished downloads in Transmission"
    echo "USAGE: $0 [-C <config-dir>]"
    echo "    -C <config-dir>   Change config directory (default: \$HOME/.checkFinishedTransmissionDownloads)"
    echo "    -h                Show help"
    exit 1
}

# Call transmission-remote with corresponding parameters
callTransmission () {
    if [ "$RPC_AUTH" -eq 0 ]
    then
        transmission-remote "$HOST":"$PORT" "$@"
    else
        transmission-remote "$HOST":"$PORT" -N "$TMP_FILE" "$@"
    fi
    # Since transmission 1.70 exit code can be used to detect errors
    if [ $? -ne 0 ]
    then
        echo "Error while accessing Transmission daemon" >&2
        exitAndClean 3
    fi
}

# Remove lock and temporary files, exit with code $1
exitAndClean () {
    [ -z "$LOCK_PID" ] || kill "$LOCK_PID"
    lockfile-remove "$LOCK_FILE"
    rm -f "$TMP_FILE" "$ALL_FILE" "$LIST_FILE" "$TMP_FILE2" "$ERROR_FILE.new"

    exit "$1"
}

# Remove torrents that deleted from downloads list from specified list file
# $1 -- list name
removeDeletedTorrents() {
    # remove deleted torrents from sent notifications list
    sort "$1" > "$TMP_FILE"
    mv "$TMP_FILE" "$TMP_FILE2"

    sort "$ALL_FILE" > "$TMP_FILE"
    mv "$TMP_FILE" "$ALL_FILE"

    comm -1 -2 "$TMP_FILE2" "$ALL_FILE" > "$TMP_FILE"
    mv "$TMP_FILE" "$1"
}

############################################################################
# MAIN
############################################################################

CONFIGPATH="$HOME/.checkFinishedTransmissionDownloads"

while getopts C:h opt
do
    case $opt in
        C)
            CONFIGPATH="$OPTARG"
        ;;
        h)
            usage
        ;;
        \?)
            usage
        ;;
    esac
    shift `expr $OPTIND - 1`
done

if [ $# -ne 0 ]
then
    usage
fi

# files
CONFIG_FILE="$CONFIGPATH/config"
NOTIFY_FILE="$CONFIGPATH/notified"
ERROR_FILE="$CONFIGPATH/error"

if [ -f "$CONFIG_FILE" ]
then
    . "$CONFIG_FILE"
else
    echo "Configuration file \`$CONFIG_FILE' does not exists"
    exit 4
fi

umask 077

lockfile-create "$LOCK_FILE" || (echo "Unable to lock lockfile!" >&2; exitAndClean 2)
lockfile-touch "$LOCK_FILE" &
LOCK_PID="$!"

MAIN_PID="$$"

trap "exitAndClean 1" HUP INT QUIT KILL

touch "$NOTIFY_FILE" "$ERROR_FILE" "$ERROR_FILE.new" "$TMP_FILE"
printf "" > "$ALL_FILE"
# generate netrc file for RPC authorisation
printf "machine %s\nlogin %s\npassword %s\n" "$HOST" "$USER" "$PASS" > "$TMP_FILE"

# main
callTransmission -l > "$TMP_FILE2" || exitAndClean 1
gawk '{
    if ($1 != "Sum:" && $1 != "ID") {
        print $1,$2
    }
}' "$TMP_FILE2" > "$LIST_FILE"

while read id percent
do
    id="`echo "$id" | sed 's/\*//'`"
    reply="`callTransmission -t "$id" -i | grep -E '^  [A-Z]'`"
    [ $? -eq 0 ] || exitAndClean 1

    name="`echo "$reply" | grep '^  Name'  | cut -c 9-`"
    hash="`echo "$reply" | grep '^  Hash'  | cut -c 9-`"
    error="`echo "$reply" | grep '^  Error'  | cut -c 10-`"
    trackerError="`echo "$reply" | grep '^  Tracker gave an error'  | cut -c 26-`"

    # check that notification is not yet sent
    grep -q "$hash" "$NOTIFY_FILE"
    if [ $? = 1 -a "$percent" = "100%" ]
    then
        printf "$MAIL_CONTENT" "$name" "http://$HOST:$PORT/" | \
            mailx $MAILTO -s "Torrents info: $name" -a "From: $FROM"
        echo "$hash" >> "$NOTIFY_FILE"
    fi

    # check that error exists and not yet reported
    if [ -n "$error" -o -n "$trackerError" ]
    then
        if ! grep -q "$hash" "$ERROR_FILE"
        then
            #print error message
            if [ -n "$error" ]
            then
                error="$error, "
            fi
            error="${error}${trackerError}"
            printf "$ERROR_CONTENT" "$name" "$error" "http://$HOST:$PORT/" | \
                mailx $MAILTO -s "Torrents info: $name" -a "From: $FROM"
        fi
        echo "$hash" >> "$ERROR_FILE.new"
    fi
    echo "$hash" >> "$ALL_FILE"
done < "$LIST_FILE"

removeDeletedTorrents "$NOTIFY_FILE"
mv "$ERROR_FILE.new" "$ERROR_FILE"

exitAndClean 0