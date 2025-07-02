#!/usr/bin/env bash

SESSION_NAME=$(tmux display-message -p '#{session_name}')

if [ "$SESSION_NAME" != "popup" ]; then
    tmux a -t popup || tmux new -s popup
else
    tmux detach
fi
