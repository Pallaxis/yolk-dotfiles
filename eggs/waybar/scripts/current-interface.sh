#!/usr/bin/env bash

STATE_FILE="/tmp/waybar-current-interface"
DEFAULT_IFACE="wlan0"

IFACE=$(cat "$STATE_FILE" 2>/dev/null || echo "$DEFAULT_IFACE")
