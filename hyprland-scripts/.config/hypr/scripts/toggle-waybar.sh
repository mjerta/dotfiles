#!/usr/bin/env bash


if pgrep -x waybar > /dev/null; then
  pkill waybar
else
  waybar &
fi
