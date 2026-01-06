#!/bin/sh

handle() {
    case $1 in monitoradded*)
        seq 1 5 | xargs -I {} hyprctl dispatch moveworkspacetomonitor {} 1
esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done
