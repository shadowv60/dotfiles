#!/bin/sh

DIR="/home/shadow/Pictures"
FILE="$DIR/$(date +%Y-%m-%d-%H%M%S)_screenshot.png"

if [ "$1" = "full" ]; then
    grim "$FILE"
elif [ "$1" = "region" ]; then
    grim -g "$(slurp)" "$FILE"
fi
