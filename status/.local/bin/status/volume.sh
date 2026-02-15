#!/bin/sh

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

# Extract percentage
percent=$(echo "$vol" | awk '{print int($2 * 100)}')

# Detect mute
echo "$vol" | grep -q MUTED && muted=1 || muted=0

if [ "$muted" -eq 1 ]; then
    echo " Muted"
else
    echo " ${percent}%"
fi
