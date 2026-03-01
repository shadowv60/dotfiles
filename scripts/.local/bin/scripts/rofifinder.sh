#!/bin/bash

# --- 1. DEFINE YOUR FAVORITES HERE ---
# Add the full paths to the files you want at the top
favorites=(
    "$HOME/.config/dwm/config.h"
    "$HOME/.config/nvim/init.lua"
    "$HOME/.config/kitty/kitty.conf"
    "$HOME/.local/bin/scripts/rofifinder.sh"
    "$HOME/.bashrc"
)

# Join the favorites into a single string with newlines
fav_list=$(printf "%s\n" "${favorites[@]}")

# --- 2. GET RECENT FILES ---
# We get the recent files but filter out the favorites so they don't appear twice
recent_list=$(fd --type f --hidden --exclude .git --changed-within 10d . "$HOME")

# --- 3. COMBINE AND SEARCH ---
# We put Favorites on top, then Recent files
selected_file=$(echo -e "$fav_list\n$recent_list" | rofi -dmenu -i -p "Quick Open (Alt+a for All):" -kb-custom-1 "Alt+a")

# --- 4. HANDLE "ALL FILES" TOGGLE ---
if [ $? -eq 10 ]; then
    selected_file=$(fd --type f --hidden --exclude .git . "$HOME" | rofi -dmenu -i -p "All Files:")
fi

# --- 5. OPEN IN NEOVIM ---
if [ -n "$selected_file" ]; then
    # Expand ~ if it exists in the path
    real_path="${selected_file/#\~/$HOME}"
    kitty --name nvim_term -e nvim "$real_path"
fi
