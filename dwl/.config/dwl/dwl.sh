#!/bin/sh
export PATH=$PATH:/usr/local/bin:/home/shadow/.local/bin
if command -v slstatus >/dev/null; then
    exec slstatus -s | dwl
else
    while true; do date +'%H:%M'; sleep 60; done | exec dwl
fi
