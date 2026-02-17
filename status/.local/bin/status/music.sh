#!/bin/sh

MAX=15

# Define your priority. We check Chromium first, then MPD.
# playerctl -l lists all active players.
CHROME_STATUS=$(playerctl -p chromium status 2>/dev/null)
MPD_STATUS=$(playerctl -p mpd status 2>/dev/null)

# Logic: If Chromium is playing, use it.
# Otherwise, if MPD exists, use MPD.
if [ "$CHROME_STATUS" = "Playing" ]; then
  PLAYER="chromium"
  status="$CHROME_STATUS"
elif [ -n "$MPD_STATUS" ]; then
  PLAYER="mpd"
  status="$MPD_STATUS"
else
  # Fallback to any other player or "No music"
  PLAYER=$(playerctl -l 2>/dev/null | head -n 1)
  status=$(playerctl status 2>/dev/null)
fi

if [ -z "$status" ]; then
  printf " No music"
  exit 0
fi

# Icon & Metadata based on the SELECTED player
icon=""
[ "$status" = "Playing" ] && icon=""

artist=$(playerctl -p "$PLAYER" metadata artist 2>/dev/null)
title=$(playerctl -p "$PLAYER" metadata title 2>/dev/null)

# Clean up text
[ -z "$artist" ] && text="$title" || text="$title - $artist"

# Truncate
if [ ${#text} -gt $MAX ]; then
  text=$(printf "%s" "$text" | cut -c 1-$((MAX - 1)))"…"
fi

printf "%s %s" "$icon" "$text"

# Handle clicks for the SPECIFIC player we are watching
case "$BLOCK_BUTTON" in
1) playerctl -p "$PLAYER" play-pause ;;
2) playerctl -p "$PLAYER" previous ;;
3) playerctl -p "$PLAYER" next ;;
esac
