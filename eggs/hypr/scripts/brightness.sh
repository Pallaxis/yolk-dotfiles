#!/usr/bin/env bash

dim_monitors() {
    # Set monitor backlight to minimum, avoid 0 on OLED monitor.
    brightnessctl -s set 10

    if [ ! -d $XDG_CACHE_HOME/monitor-save/ ]; then
        mkdir $XDG_CACHE_HOME/monitor-save/
    fi
    # Save brightness, then set to 10
    ddcutil getvcp 0x10 | awk '{print $9}' | tr -d ',' > $XDG_CACHE_HOME/monitor-save/value
    ddcutil setvcp 0x10 10
}

restore_brightness(){
    brightnessctl -r			    # Monitor backlight restore.

    previous=$(cat $XDG_CACHE_HOME/monitor-save/value)
    ddcutil setvcp 0x10 $previous
}

# Check if the first argument is supplied and if the function exists
if [ -n "$1" ] && declare -f "$1" > /dev/null; then
    "$1"  # Call the function with the name provided as the first argument
else
    echo "Function '$1' does not exist or no function name provided."
fi
