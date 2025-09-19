#!/usr/bin/env bash

handle() {
  case $1 in
    monitoraddedv2*) sleep 6; ddcutil setvcp 0x10 100 ;;
    # focusedmon*) do_something_else ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
