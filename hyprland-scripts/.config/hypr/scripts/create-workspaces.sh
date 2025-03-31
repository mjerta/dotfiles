#!/usr/bin/env bash
# Get monitor information
MONITOR_INFO=$(hyprctl monitors all)

# Check if DP-4 is a BNQ monitor
BNQ_INFO=$(echo "$MONITOR_INFO" | awk '/Monitor DP-4/,/make: / {if ($1 == "make:") print substr($0, index($0,$2))}')
WORKSPACE_CONFIG_FILE="$HOME/.config/hypr/conf/workspace_config.conf"

# Clear the file before writing
>"$WORKSPACE_CONFIG_FILE"

if [[ "$BNQ_INFO" == "BNQ" ]]; then

  for i in {1..5}; do
    echo "workspace= $i,monitor:DP-5, default:true" >>"$WORKSPACE_CONFIG_FILE"
  done
  for i in {6..7}; do
    echo "workspace= $i,monitor:eDP-1, default:true" >>"$WORKSPACE_CONFIG_FILE"
  done
  for i in {8..10}; do
    echo "workspace= $i,monitor:DP-4, default:true" >>"$WORKSPACE_CONFIG_FILE"
  done
else
  for i in {1..5}; do
    echo "workspace= $i,monitor:DP-4, default:true" >>"$WORKSPACE_CONFIG_FILE"
  done

  for i in {6..10}; do
    echo "workspace= $i,monitor:eDP-1, default:true" >>"$WORKSPACE_CONFIG_FILE"
  done
fi
