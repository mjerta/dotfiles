#!/usr/bin/env bash

# Default location
default_location="$HOME/develop/projects"

# Prompt for folder name
read -p "Enter folder name (default location: $default_location): " folder_name

# Check if folder name is empty
if [[ -z "$folder_name" ]]; then
  echo "Folder name cannot be empty."
  exit 1
fi

# Full path to the new folder
new_folder="$default_location/$folder_name"

# Create the folder
mkdir -p "$new_folder"

# Get the session name by replacing dots with underscores
session_name=$(basename "$new_folder" | tr . _)

# Check if tmux is running
tmux_running=$(pgrep tmux)

# Start or attach to a tmux session
if [[ -z $TMUX ]]; then
  if [[ -z $tmux_running ]]; then
    tmux new-session -s $session_name -c $new_folder
  else
    tmux attach-session -t $session_name || tmux new-session -s $session_name -c $new_folder
  fi
  exit 0
else
  if ! tmux has-session -t=$session_name 2>/dev/null; then
    tmux new-session -ds $session_name -c $new_folder
  fi
  tmux switch-client -t $session_name
fi
