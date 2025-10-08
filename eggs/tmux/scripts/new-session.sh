#!/usr/bin/env bash

script_dir="$HOME/.config/tmux/sessions"
session_scripts=$(find "$script_dir" -mindepth 1 -type f -executable -printf "%f\n")
active_sessions+=$(tmux list-sessions | awk -F':' '{print $1}')
combined_sessions=$(printf "%s\n%s" "$session_scripts" "$active_sessions" | sort -u)

# Use rofi to prompt the user
chosen=$(echo "$combined_sessions" | rofi -dmenu -i -p "Select session or create new:")

# Exit if no selection
[ -z "$chosen" ] && exit
if echo "$active_sessions" | grep -qx "$chosen"; then
    tmux switch-client -t "$chosen"
elif echo "$session_scripts" | grep -qx "$chosen"; then
    # Runs tmux session setup
    "$script_dir"/"$chosen"
else
    # Create a new tmux session with that name
    tmux new-session -Ad -c ~ -s "$chosen"
    tmux switch-client -t "$chosen"
fi
