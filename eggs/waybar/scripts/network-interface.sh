#!/usr/bin/env bash

netstat -i | awk 'NR > 2 {print $1}' | grep -v 'lo' | rofi -dmenu


#!/bin/bash

STATE_FILE="/tmp/waybar-network-interface"

# List of interfaces to toggle through (customize this!)
IFACES=$(netstat -i | awk 'NR > 2 {print $1}' | grep -v 'lo')

# Get current iface from state file or default to first
if [[ -f "$STATE_FILE" ]]; then
    CURRENT=$(cat "$STATE_FILE")
else
    CURRENT="${IFACES[0]}"
fi

# Find index of current iface
for i in "${!IFACES[@]}"; do
    if [[ "${IFACES[$i]}" == "$CURRENT" ]]; then
        NEXT_INDEX=$(( (i + 1) % ${#IFACES[@]} ))
        break
    fi
done

# Write next iface to state file
echo "${IFACES[$NEXT_INDEX]}" > "$STATE_FILE"

