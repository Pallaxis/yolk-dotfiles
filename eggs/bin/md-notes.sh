#!/usr/bin/env bash

notesfolder=~/docs/markdown-notes/
TERMINAL=alacritty


newnote () { \
    name="$(echo "" | rofi -dmenu -p "Enter a name: " <&-)"
    setsid -f "$TERMINAL" -e nvim $notesfolder$name".md" &> /dev/null
}

selected () { \
    choice=$(echo -e "New\n$(ls -t1 $notesfolder | grep '.md')" | rofi -dmenu -p "Choose note or create new: ")
    case $choice in
        New) newnote;;
        *md) setsid -f "$TERMINAL" -e nvim "$notesfolder$choice" &> /dev/null;;
        *) exit;;
    esac
}

main() {
    setsid -f "$TERMINAL" -e nvim $notesfolder
}

selected
