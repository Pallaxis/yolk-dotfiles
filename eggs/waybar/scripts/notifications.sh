#!/usr/bin/env bash
# Returns most recent Dunst history entry & a nice little icon for waybar to use

text_output=""
summary=$(dunstctl history | jq -r '.data[0][0].summary.data')
appname=$(dunstctl history | jq -r '.data[0][0].appname.data')

if [[ $summary == "null" ]]; then
    exit
fi

#tooltip="appname: $appname\nsummary: $summary"
tooltip=$(dunstctl history | jq -r '[.data[0][] | "\(.appname.data)\\n\(.summary.data)\\n\\n"] | join("")' | sed 's/\\n\\n$//')
echo "{\"text\": \"$text_output\", \"tooltip\": \"$tooltip\"}"
