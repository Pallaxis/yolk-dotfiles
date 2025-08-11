#!/usr/bin/env bash
# Script to change volume & show a pretty notification using Dunst

# Arbitrary but unique message tag
msgTag="volumeControl"

# Change volume based on script argument
wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ "$@"

# Query wpctl for the current volume and whether or not the speaker is muted
pre_volume="$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')"
volume="$(calc "$pre_volume * 100")"
dunstify -a $msgTag -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag -h int:value:"$volume" "Volume: ${volume}%"

# Play the volume changed sound (unused)
#canberra-gtk-play -i audio-volume-change -d "changeVolume"
