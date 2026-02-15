#!/bin/sh

# Get active connection name and type
active=$(nmcli -t -f TYPE,STATE,CONNECTION dev | grep ':connected')

if [ -z "$active" ]; then
    printf "󰤭 Offline"
    exit 0
fi

type=$(echo "$active" | cut -d: -f1)
name=$(echo "$active" | cut -d: -f3)

case "$type" in
    wifi)
        printf " %s" "$name"
        ;;
    ethernet)
        printf "󰈀 Ethernet"
        ;;
    *)
        printf "󰌘 %s" "$name"
        ;;
esac
