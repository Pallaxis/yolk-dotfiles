#!/usr/bin/env bash
# changeVolume

# Arbitrary but unique message tag
msgTag="volumecontrol"

# Change volume based on script argument
wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ "$@"

# Query wpctl for the current volume and whether or not the speaker is muted
pre_volume="$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')"
volume="$(calc "$pre_volume * 100")"
mute="$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $3}')"
if [[ $volume == 0 || "$mute" == "[MUTED]" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "Volume muted" 
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "Volume: ${volume}%"
fi

# Play the volume changed sound (unused)
#canberra-gtk-play -i audio-volume-change -d "changeVolume"
