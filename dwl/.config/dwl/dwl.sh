#!/bin/sh

# 1. Setup Path
export PATH=$PATH:/usr/local/bin:/home/shadow/.local/bin

# 2. Start background processes
# We add a tiny sleep to ensure dwl is 'ready' to receive the background
(sleep 0.5 && swaybg -i /home/shadow/walls/hell.png -m fill) &

# 3. Launch dwl
# If slstatus is missing, we use a fallback loop so dwl doesn't crash
if command -v slstatus >/dev/null; then
    slstatus -s | exec dwl
else
    while true; do date +'%H:%M'; sleep 60; done | exec dwl
fi
