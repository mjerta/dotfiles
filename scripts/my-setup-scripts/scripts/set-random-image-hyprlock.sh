#!/usr/bin/env bash

IMAGE_DIR="$HOME/.config/wallpapers/"
RANDOM_IMAGE=$(find "$IMAGE_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
echo "export RANDOM_IMAGE=\"$RANDOM_IMAGE\""
