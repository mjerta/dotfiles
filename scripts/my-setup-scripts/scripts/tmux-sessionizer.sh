#!/usr/bin/env bash

# Function to search directories with fzf
search_dirs() {
  local dir="$1"

  find -L "$dir" -mindepth 1 -maxdepth 1 -type d |
    awk '{print NR ": " $0}' |
    fzf --reverse \
      --header=$'TMUX-SESSIONIZER \nSearching inside:'"$dir"$' \nCTRL-p for ~/.config\nCTRL-f for ~/dotfiles\nCTRL-d for ~/develop/projects\nCTRl-t for ~/develop/testing\nCTRL-n for ~/notes\n\n' \
      --bind "ctrl-p:reload(find -L ~/.config ~/my-setup-scripts -mindepth 1 -maxdepth 1 -type d | awk '{print NR \": \" \$0}')" \
      --bind "ctrl-f:reload(find -L ~/dotfiles -mindepth 1 -maxdepth 1 -type d | awk '{print NR \": \" \$0}')" \
      --bind "ctrl-d:reload(find -L $DEVELOP/projects -mindepth 1 -maxdepth 1 -type d | awk '{print NR \": \" \$0}')" \
      --bind "ctrl-t:reload(find -L $DEVELOP/testing -mindepth 1 -maxdepth 1 -type d | awk '{print NR \": \" \$0}')" \
      --bind "ctrl-n:reload(find -L ~/notes -mindepth 1 -maxdepth 1 -type d | awk '{print NR \": \" \$0}')" \
      --bind 'enter:accept' |
    cut -d: -f2-
}

# Start searching in ~/develop/projects by default
selected=$(search_dirs "$DEVELOP/projects")

if [[ -z $selected ]]; then
  echo $selected
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]]; then
  if [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
  else
    tmux attach-session -t $selected_name || tmux new-session -s $selected_name -c $selected
  fi
  exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
  tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
