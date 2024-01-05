#!/usr/bin/env bash

MYHOME=/Users/robert
ORG_FILE=$MYHOME/org/memacs/lastfm.org_archive
MEMACS=/opt/homebrew/bin/memacs_lastfm

mv $ORG_FILE ${ORG_FILE}.bak

$MEMACS --config ~/.config/memacs/memacs-lastfm.ini \
	--output $ORG_FILE
