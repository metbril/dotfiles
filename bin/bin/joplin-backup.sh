#!/bin/bash

#export NODEJS_HOME=/usr/local/lib/nodejs/node-v10.15.3/bin
#export NODEJS_GLOBAL_HOME=$HOME/.node_modules_global/bin

#PATH=$HOME/bin:$NODEJS_GLOBAL_HOME:$NODEJS_HOME:$PATH
#export PATH

#D=`date +'%Y-%m-%d'`
D=`date +'%Y-%m-%d_%H-%M'`

mkdir -p $HOME/backup/joplin

echo 'Started sync.'
date "+%Y-%m-%dT%H:%M:%S%z"
#joplin sync >> $HOME/Library/Logs/joplin-backup.log 2>&1
joplin sync

echo 'Started export.'
date "+%Y-%m-%dT%H:%M:%S%z"
#joplin export --format jex $HOME/backup/joplin/joplin_${D}.jex >> $HOME/Library/Logs/joplin-backup.log 2>&1
joplin export --format jex $HOME/backup/joplin/joplin_${D}.jex

echo 'Remove old backups...'
#find /data/backup/joplin/ -name '*.jex' -mtime +28 -exec rm {} \;

echo 'Finished backup.'
date "+%Y-%m-%dT%H:%M:%S%z"