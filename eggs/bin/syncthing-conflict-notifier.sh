#!/bin/bash
# Edit variable value with root location of a syncthing folder that needs to be watched
SYNCTHING_DIR=$HOME/share/syncthing/

if [[ -n `ls -1 "$SYNCTHING_DIR"/*.sync-conflict-* 2> /dev/null` ]]
then
    CONFLICT=$(notify-send --urgency=critical "NEW SYNCTHING CONFLICTS DETECTED!!" --action="action")

    case $CONFLICT in
        0) $(keepassxc); printf "done";;
        *) exit;;
    esac
fi
