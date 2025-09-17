#!/usr/bin/env bash
# Creates/Attaches to a tmux session then spawns 15 windows each running
# rvp-ats/lib/client.py for their respective burnin station
# Made by Henry Paradise

SESSION="burnin-monitoring"

# Create or attach to session (detached)
tmux new-session -Ad -s "$SESSION"

# Loop to create 15 windows
for i in $(seq -w 1 15); do
    WINDOW_NAME="burn$i"
    HOSTNAME="burn$i"
    COMMAND="ssh $HOSTNAME 'source venv/bin/activate && python3 rvp-ats/lib/client.py'; bash"

    tmux new-window -t "$SESSION" -n "$WINDOW_NAME" "$COMMAND"
    sleep 0.1
done

# Kill default window if it exists
tmux kill-window -t "$SESSION:1" 2>/dev/null

tmux attach -t "$SESSION"
