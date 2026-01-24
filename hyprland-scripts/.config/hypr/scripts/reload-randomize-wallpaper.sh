#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/wallpapers/"

# Get currently loaded wallpaper path and extract just the filename
CURRENT_WALL=$(hyprctl hyprpaper listloaded | head -n1 | xargs basename)

# Pick a random wallpaper (different from current)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$CURRENT_WALL" | shuf -n 1)

# Preload and apply (modern IPC method)
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ",$WALLPAPER"
hyprctl hyprpaper unload unused
