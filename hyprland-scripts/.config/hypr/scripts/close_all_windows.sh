#!/bin/bash

# Fetch all windows and filter out the PID lines
pids=$(hyprctl clients | grep -oP 'pid: \K\d+')

# Loop through the PIDs
for pid in $pids; do
    # Echo the PID for review
    echo "Killing window with PID: $pid"

    # Kill the window using the PID
    hyprctl dispatch killwindow pid:$pid
done

