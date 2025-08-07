#!/usr/bin/env bash

WALLPAPER_DIR=$HOME/.local/share/wallpapers/
CURRENT_WALL=$(basename $(hyprctl hyprpaper listloaded))

main () {
    CHOICE=$(echo -e "$(ls -t1 "$WALLPAPER_DIR")" | rofi -dmenu -p "Select a wallpaper: ")

    if [[ -n "$CHOICE" && "$CHOICE" != "$CURRENT_WALL" ]]; then
        hyprctl hyprpaper reload ,"${WALLPAPER_DIR}${CHOICE}"
    fi
}

main
