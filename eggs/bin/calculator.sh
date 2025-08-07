#!/usr/bin/env bash

INPUT=$(rofi -dmenu)

OUTPUT=$(calc $INPUT)

notify-send $OUTPUT
