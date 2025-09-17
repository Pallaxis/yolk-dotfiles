#!/usr/bin/env bash

session_name="Update"
alacritty_workspace=$(hyprctl clients | awk '/Window .* Alacritty/{for(i=0;i<5;i++) getline; print $2; exit}')

# First ensure we're on our terminal workspace
hyprctl dispatch workspace 2

# Create update session
# tmux new-session -Ad -s "$session_name"
tmux new-session -d -s "$session_name"

# If theres no session named Update, create it and send the command as a key so it doesn't exit on complete
# if ! tmux has-session -t "$session_name"; then
#     tmux new-session -n "$session_name" -s "$session_name" -d
#     tmux send-keys -t "$session_name" "$HOME/.local/bin/update.sh" Enter
# fi

# Check if our client is attached
attached_client=$(tmux list-clients -F "#{client_tty}" 2>/dev/null | head -n 1)
if [[ -n "$attached_client" ]]; then
    tmux switch-client -t "$session_name"
else
    tmux attach-session -t "$session_name"
fi

pacman_running=$(pidof pacman)
yay_running=$(pidof yay)

if [[ -z $pacman_running && -z $yay_running ]]; then
    # tmux send-keys -t "$session_name" "$HOME/.local/bin/update.sh" Enter
    tmux new-window -t $session_name:1 -k -n "Update" "$HOME/.local/bin/update.sh"
fi
