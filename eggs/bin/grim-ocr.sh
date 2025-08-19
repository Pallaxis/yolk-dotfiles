#!/usr/bin/env bash

#if ! command -v tesseract >/dev/null 2>&1; then

GRIMBLAST_TEMP=$(mktemp -d)

OUTPUT_TEXT=$(grimblast --freeze copysave area $GRIMBLAST_TEMP/image.png > /dev/null && tesseract $GRIMBLAST_TEMP/image.png - 2> /dev/null)

rm -r $GRIMBLAST_TEMP

notify-send -- "$OUTPUT_TEXT"
wl-copy -- "$OUTPUT_TEXT"

exit
