#!/usr/bin/env bash

notesfolder=~/docs/markdown-notes/
TERMINAL=alacritty

main() {
    date_filename=$(date +%d-%m-%Y)
    setsid -f "$TERMINAL" -e nvim $notesfolder/daily-notes/${date_filename}.md
}

main
