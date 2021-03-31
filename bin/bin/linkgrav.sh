#!/bin/bash

# link a grav plugin or theme from the code folder to the mamp installation

# repo name
repo=$HOME/code/grav-$1-$2
#echo "==> $repo"
if [ ! -d "$repo" ] 
then
    echo "Repo $repo does not exist." 
    exit 1 # die with error code 1
fi

# MAMP
MAMP=$HOME/shared/mamp-grav
if [ ! -d "$MAMP" ] 
then
    echo "Directory $MAMP does not exist." 
    exit 1 # die with error code 1
fi

# dest
dest=$MAMP/user/$1s/$2
#echo "==> $dest"
if [ -e "$dest" ] || [ -h "$dest" ]
then
    echo "File $dest already exists." 
    exit 1 # die with error code 1
fi

ln -s $repo $dest
