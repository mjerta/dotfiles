#!/usr/bin/env bash

# Get monitor information
MONITOR_INFO=$(hyprctl monitors all)

# Check if DP-4 is a BNQ monitor
BNQ_INFO=$(echo "$MONITOR_INFO" | awk '/Monitor DP-4/,/make: / {if ($1 == "make:") print substr($0, index($0,$2))}')
WORKSPACE_CONFIG_FILE="$HOME/.config/hypr/conf/workspace_config.conf"

if [[ "$BNQ_INFO" == "BNQ" ]]; then
  notify-send "Detected BNQ monitor"

  # Configure monitors
  hyprctl keyword monitor "eDP-1,preferred,0x0,1"
  hyprctl keyword monitor "DP-5,preferred,1366x0,1"
  hyprctl keyword monitor "DP-4,preferred,3286x0,1,transform,1"
else
  notify-send "Mjerta downstairs setup detected"
  # Configure monitors
  hyprctl keyword monitor "eDP-1,preferred,0x0,1"
  hyprctl keyword monitor "DP-3,preferred,auto-left,1"
fi
