#!/usr/bin/env bash
# Simple rofi menu that shows a list of options and handles them by on a case basis

config="$HOME/.config/rofi/logout-menu.rasi"
options=$(
    echo " Lock"
    echo "󰤄 Sleep"
    echo "⏻ Power Off"
    echo " Reboot"
    echo "󰗽 Logout"
)

# Kill rofi if it's running or show rofi with our options otherwise
selection=$(pkill rofi || echo -e "$options" | rofi -dmenu -no-custom -i -p "Logout Menu" -config "${config}")
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
