#!/bin/sh

# Maximum length for the output
MAX=20

status=$(playerctl status 2>/dev/null)

if [ -z "$status" ]; then
    printf " No music"
    exit 0
fi

# Icon
icon=""
[ "$status" = "Playing" ] && icon=""

# Artist & title
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

text="$artist - $title"

# Truncate if too long
if [ ${#text} -gt $MAX ]; then
    text="${text:0:MAX-1}…"
fi

printf "%s %s" "$icon" "$text"

# Handle clicks
case "$BLOCK_BUTTON" in
    1) playerctl play-pause ;;    # left click
    3) playerctl next ;;          # right click
    2) playerctl previous ;;      # middle click
esac
