#!/bin/bash

# Prompt for the project name
if [[ -z "$1" ]]; then
  read -p "Enter the project name: " PROJECT_NAME
else
  PROJECT_NAME="$1"
  echo "$PROJECT_NAME"
fi

# Check if the project name is empty
if [ -z "$PROJECT_NAME" ]; then
  echo "Project name cannot be empty. Exiting."
  exit 1
fi

# Prompt for the group ID
read -p "Enter the group ID (default: nl.mpdev): " GROUP_ID
GROUP_ID=${GROUP_ID:-nl.mpdev}

# Initialize the Spring Boot project with Maven and additional parameters
spring init --java-version=21 \
  --build=maven \
  --packaging=jar \
  --artifact-id="$PROJECT_NAME" \
  --group-id="$GROUP_ID" \
  --dependencies=web,devtools,data-rest,data-jpa,lombok,postgresql \
  --extract \
  --name="$PROJECT_NAME" \
  "$PROJECT_NAME"

if [[ -z "$1" ]]; then
  # Get the full path of the current directory
  FULL_PATH=$(pwd)

  # Change to the new project directory
  cd "$FULL_PATH/$PROJECT_NAME" || {
    echo "Failed to change directory to $FULL_PATH/$PROJECT_NAME"
    exit 1
  }

  # Print the new directory to confirm
  echo "Changed directory to $(pwd)"

  # Rename gitignore to .gitignore if it exists
  if [ -f "gitignore" ]; then
    echo "Renaming gitignore to .gitignore"
    mv "gitignore" ".gitignore"
    notify-send "gitignore detecetd anc change to .gitignore"
  else 
    notify-send ".gitignore was already created"
  fi

  echo "Project $PROJECT_NAME has been created and setup successfully."
  exec bash
fi
