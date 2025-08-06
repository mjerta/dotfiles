#!/usr/bin/env bash

WALLPAPER=$(find /home/mjerta/.config/wallpapers/ -type f -name '*.png' | shuf -n 1)
cp "$WALLPAPER" /usr/share/backgrounds/current_wallpaper.png

# Check if the copy command was successful
if [ $? -ne 0 ]; then
    notify-send "Wallpaper Update" "Failed to copy the wallpaper."
fi
