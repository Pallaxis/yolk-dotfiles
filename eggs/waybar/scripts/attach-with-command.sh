#!/usr/bin/env bash

SESSION="general"
COMMAND="$1"

# Create the session if it doesn't exist
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
    tmux new-session -s "$SESSION" -n main -d
fi

# Create a new window in the session and run the command there
# this one is to keep the window open after
#tmux new-window -t "$SESSION" -n "$COMMAND"
#tmux send-keys -t "$SESSION:$COMMAND" "$COMMAND" Enter

# Create a new window and run the command; exit afterward
tmux new-window -t "$SESSION" -n "$COMMAND" \
    "bash -c '$COMMAND'"

# Find the first attached client (if any)
ATTACHED_CLIENT=$(tmux list-clients -F "#{client_tty}" 2>/dev/null | head -n 1)

if [[ -n "$ATTACHED_CLIENT" ]]; then
    notify-send --urgency=normal "Switching attached client ($ATTACHED_CLIENT) to session $SESSION"
    tmux switch-client -t "$SESSION:$COMMAND"
else
    notify-send --urgency=normal "No attached clients. Attaching to $SESSION:$COMMAND"
    tmux attach-session -t "$SESSION" -c "$COMMAND"
fi
