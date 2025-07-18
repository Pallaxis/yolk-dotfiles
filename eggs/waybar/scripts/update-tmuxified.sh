#!/usr/bin/env bash

UPDATE_SESSION="Update"

# Create a new session (in background)
#tmux new-session -n "$UPDATE_SESSION" -s "$UPDATE_SESSION" ~/.local/bin/update.sh

# If theres no session named Update, create it and send the command as a key so it doesn't exit on complete
if ! tmux has-session -t "$UPDATE_SESSION"; then
    tmux new-session -n "$UPDATE_SESSION" -s "$UPDATE_SESSION" -d
    tmux send-keys -t "$UPDATE_SESSION" "~/.local/bin/update.sh" Enter
fi

# Find the first attached client (if any)
ATTACHED_CLIENT=$(tmux list-clients -F "#{client_tty}" 2>/dev/null | head -n 1)

if [[ -n "$ATTACHED_CLIENT" ]]; then
    notify-send --urgency=normal "Switching attached client ($ATTACHED_CLIENT) to session $UPDATE_SESSION"
    tmux switch-client -t "$UPDATE_SESSION"
else
    notify-send --urgency=normal "No attached clients. Attaching to $UPDATE_SESSION"
    tmux attach-session -t "$UPDATE_SESSION"
fi
