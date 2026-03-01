#!/bin/bash
options="󰐥 Shutdown\n󰜉 Reboot\n󰤄 Suspend\n󰗼 Logout"

# Added formatting flags to shrink the window
selected=$(echo -e "$options" | rofi -dmenu -i -p "System:" \
    -l 4 \
    -width 12 \
    -hide-scrollbar \
    -bw 2)

case $selected in
    *"Shutdown") poweroff ;;
    *"Reboot") reboot ;;
    *"Suspend") systemctl suspend ;;
    *"Logout") pkill dwm ;;
esac
