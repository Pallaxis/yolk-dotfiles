#!/usr/bin/env bash
# Goes to default terminal workspace, manipulates tmux to attach with update script

hyprctl dispatch workspace 2
session_name="Update"
export PATH="$HOME/.local/share/system-setup/bin/:$PATH"

# Create update session
tmux new-session -d -s "$session_name"

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
    tmux new-window -t $session_name:1 -k -n "Update" "$HOME/.local/share/system-setup/bin/update"
fi
