#!/usr/bin/env bash

notesfolder=~/docs/notes/
TERMINAL=alacritty


newnote () { \
    name="$(echo "" | rofi -dmenu -p "Enter a name: " <&-)"
    setsid -f "$TERMINAL" -e nvim $notesfolder$name".txt" &> /dev/null
}

selected () { \
    choice=$(echo -e "New\n$(ls -t1 $notesfolder | grep '.txt')" | rofi -dmenu -p "Choose note or create new: ")
    case $choice in
        New) newnote;;
        *txt) setsid -f "$TERMINAL" -e nvim "$notesfolder$choice" &> /dev/null;;
        *) exit;;
    esac
}

selected
