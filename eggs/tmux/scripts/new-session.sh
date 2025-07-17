#!/usr/bin/env bash

# Get the list of tmuxp sessions
sessions=$(tmuxp ls 2>/dev/null)

# Use rofi to prompt the user
chosen=$(echo "$sessions" | rofi -dmenu -i -p "Tmuxp session or new name:")

# Exit if no selection
[ -z "$chosen" ] && exit

# If the chosen input matches an existing tmuxp session
if echo "$sessions" | grep -qx "$chosen"; then
    # Load the tmuxp session
    tmuxp load "$chosen" --yes > /dev/null 2>&1
else
    # Create a new tmux session with that name
    tmux new-session -Ad -c ~ -s "$chosen"
    tmux switch-client -t "$chosen"
fi
