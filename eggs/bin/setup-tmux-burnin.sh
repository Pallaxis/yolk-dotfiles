#!/usr/bin/env bash
# Creates/Attaches to a tmux session with one all 15 burnin stations split into
# two labelled windows
# Made by Henry Paradise

SESSION="burnin-test"

# Create or attach to session (detached)
tmux new-session -Ad -s "$SESSION"

# Setting up both windows using their index explicitly
tmux new-window -t $SESSION:0 -k -n "0-8 3.2.0-rc3 both" -c ~/rvp-ats-ansible-platbook-rpi
tmux new-window -t $SESSION:1 -k -n "9-15 same" -c ~/rvp-ats-ansible-platbook-rpi_2

tmux attach -t "$SESSION"
