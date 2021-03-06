#!/bin/bash

#COMPUTER_NAME=$(/usr/sbin/scutil --get ComputerName)

if [ -z "$1" ]
then
    echo "must specifyo backup id: YYYY-MM-DD-HHMMSS"
    return 1
fi

FOUND_BACKUP=0;
BACKUPS=""
while read line; do
    if [[ "${line}" == *$1* ]]
    then
        FOUND_BACKUP=1;
    fi

    if [ "${FOUND_BACKUP}" == "1" ]
    then
        BACKUPS+="${line}"$'\n'
    fi
done < <(/usr/bin/tmutil listbackups | tail -r)

echo -n "Delete above backups? [y/N]? "
read answer
case $answer in
    y*)
        while read line; do
            if [ -n "${line}" ]
            then
                echo Running: /usr/bin/sudo /usr/bin/tmutil delete "${line}"
                /usr/bin/sudo time /usr/bin/tmutil delete "${line}"
            fi
        done < <(echo "${BACKUPS}")
        ;;
    *)
        echo No change
        ;;
esac
