#!/usr/bin/env bash

script_dir="$HOME/.config/tmux/sessions"
# Get the list of tmuxp sessions
sessions=$(find "$script_dir" -mindepth 1 -type f -executable -printf "%f\n")

# Use rofi to prompt the user
chosen=$(echo "$sessions" | rofi -dmenu -i -p "Select session or create new:")

# Exit if no selection
[ -z "$chosen" ] && exit

if echo "$sessions" | grep -qx "$chosen"; then
    # Runs tmux session setup
    "$script_dir"/"$chosen"
else
    # Create a new tmux session with that name
    tmux new-session -Ad -c ~ -s "$chosen"
    tmux switch-client -t "$chosen"
fi
