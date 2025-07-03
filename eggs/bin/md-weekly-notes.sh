#!/usr/bin/env bash

NOTES_FOLDER=~/docs/markdown-notes/
TERMINAL=alacritty

main() {
    date_filename=week-$(date +%V).md
    NOTE_PATH=$NOTES_FOLDER/weekly-notes/${date_filename}

    setsid -f "$TERMINAL" -e cd "$NOTES_FOLDER" && nvim "$NOTE_PATH"
}

main
