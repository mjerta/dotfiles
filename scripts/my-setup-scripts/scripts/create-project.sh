#!/usr/bin/env bash
# Setting some default values
base_location="$HOME/develop/"
projects[1]='testing'
projects[2]='projects'
type[1]='Java'
type[2]='Vite'
type[3]='Empty'

create_welcome_message() {
  clear
  if [[ -n $1 ]]; then
    echo -e "\n\e[1;32m\e[1;5mCREATE NEW PROJECT - starting in: $1\e[0m\n"
  else
    echo -e "\n\e[1;32m\e[1;5mCREATE NEW PROJECT\e[0m\n"
  fi
}
#First run
create_welcome_message

menu=''
for key in "${!projects[@]}"; do
  menu+="Press $key for ${projects[$key]}\n"
done
read_out_default_location() {
  echo -n -e "$menu"
  if [[ "$1" == true ]]; then
    echo "$2"
  fi
  read -rsn1 destination_choice
}

# Second run
isDestinationCorrect=true
while true; do
  if [[ "$isDestinationCorrect" == false ]]; then
    create_welcome_message
    invalid_choice_message="Invalid choice. Please try again."
    read_out_default_location true "$invalid_choice_message"
  else
    create_welcome_message
    read_out_default_location
  fi
  if [[ "$destination_choice" == $'\e' ]]; then
    echo "Exiting..."
    exit 0
  elif [[ ! -v projects[$destination_choice] || -z "$destination_choice" ]]; then
    isDestinationCorrect=false
  else
    default_location="${projects[$destination_choice]}"
    break
  fi
done

# Thith run
while true; do
  create_welcome_message "$base_location$default_location"
  echo -e "What is the name of the project: "
  # Skipping the esc capability for now
  read -r project_name
  if [[ -z "$project_name" ]]; then
    echo "The name can not be empty"
  else
    break
  fi
done

menu=''
for key in "${!type[@]}"; do
  menu+="Press $key for ${type[$key]}\n"
done

read_out_location() {
  echo -n -e "$menu"
  if [[ "$1" == true ]]; then
    echo "$2"
  fi
  if [[ "$2" == true ]]; then
    echo "$3"
  fi
  read -rsn1 type_project
}

# Fourth run
is_first_run=false
is_available=true
while true; do
  if [[ "$is_first_run" == true ]]; then
    create_welcome_message "$base_location$default_location/$project_name"
    empty_folder_message="Folder name cannot be empty."
    read_out_location true "$empty_folder_message"
    is_first_run=false
  elif [[ "$is_available" == false ]]; then
    is_not_available_message="This option is not available yet"
    create_welcome_message "$base_location$default_location/$project_name"
    read_out_location false true "$is_not_available_message"
    is_available=true
  else
    create_welcome_message "$base_location$default_location/$project_name"
    read_out_location
  fi
  if [[ "$type_project" == $'\e' ]]; then
    exit 0
  elif [[ -z "$type_project" ]]; then
    is_first_run=true
  else
    type_project="${type[$type_project]}"
    new_folder="$base_location$default_location/$project_name"
    # Adding all options in for creating the type of project
    if [[ "$type_project" == "Empty" ]]; then
      mkdir -p "$new_folder"
      break
    else
      is_available=false
    fi
  fi
done

# Get the session name by replacing dots with underscores
session_name=$(basename "$new_folder" | tr . _)
# Check if tmux is running
tmux_running=$(pgrep tmux)

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
