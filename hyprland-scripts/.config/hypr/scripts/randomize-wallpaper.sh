#!/usr/bin/env bash

# Directory with wallpapers
WALLPAPER_DIR="$HOME/.config/wallpapers/"

# Pick a random file
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Output temp Hyprpaper config
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

cat > "$CONFIG_FILE" <<EOF
preload = $RANDOM_WALLPAPER
wallpaper = ,$RANDOM_WALLPAPER
EOF

