#!/usr/bin/env bash

# Toggle state, assuming only one rofi can run at a time
if pidof rofi > /dev/null; then
    pkill rofi
    exit
fi

config="$HOME/.config/rofi/logout-menu.rasi"
options=$(
    echo " Lock"
    echo "󰤄 Sleep"
    echo "⏻ Power Off"
    echo " Reboot"
    echo "󰗽 Logout"
)
selection=$(echo -e "$options" | rofi -dmenu -no-custom -i -p "Logout Menu" -config "${config}")

if [[ -z $selection ]]; then
    exit
fi

case "$selection" in
    " Lock")
        sleep 0.5
        loginctl lock-session
        ;;
    "󰤄 Sleep")
        systemctl suspend
        ;;
    "⏻ Power Off")
        systemctl poweroff
        ;;
    " Reboot")
        systemctl reboot
        ;;
    "󰗽 Logout")
        loginctl terminate-user ''
        ;;
    *)
        echo "how did we get here"
        ;;
esac
