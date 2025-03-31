#!/bin/bash

# Prompt the user for the project name
if [[ -z "$1" ]]; then
  read -p "Enter the project name: " PROJECT_NAME
else
  PROJECT_NAME="$1"
fi

# Generate the Maven project
mvn archetype:generate \
  -DgroupId=nl.mpdev \
  -DartifactId=${PROJECT_NAME} \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false

# Inform the user the project has been created
echo "Project ${PROJECT_NAME} has been generated successfully."
if [[ -z "$1" ]]; then
  cd $(pwd)/${PROJECT_NAME}
  exec bash
fi
