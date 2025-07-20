#!/usr/bin/env bash
# Fail-fast on any error caused by external scriptssc 
set -e
# Setting some default values
base_location="$HOME/develop/"
projects[1]='testing'
projects[2]='projects'

type[1]='Java'
type[2]='Springboot'
type[3]='Vite'
type[4]='Empty'

create_welcome_message() {
  clear
  ORANGE='\033[38;5;214m'
  NC='\033[0m'

  echo -e "${ORANGE}╔╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╤╗${NC}"
  echo -e "${ORANGE}╟┼┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┼╢${NC}"
  echo -e "${ORANGE}╟┤                                           ├╢${NC}"
  echo -e "${ORANGE}╟┤   \033[38;5;109m___  ____  ____   __  ____  ____\033[0m        ${ORANGE}├╢${NC}"
  echo -e "${ORANGE}╟┤  \033[38;5;109m/ __)(  _ \(  __) / _\(_  _)(  __)\033[0m       ${ORANGE}├╢${NC}"
  echo -e "${ORANGE}╟┤ \033[38;5;109m( (__  )   / ) _) /    \ )(   ) _) \033[0m       ${ORANGE}├╢${NC}"
  echo -e "${ORANGE}╟┤  \033[38;5;109m\___)(__\_)(____)\_/\_/(__) (____)\033[0m       ${ORANGE}├╢${NC}"
  echo -e "${ORANGE}╟┤ \033[38;5;142m ____  ____   __     __  ____  ___  ____\033[0m  ${ORANGE}├╢${NC}"
  echo -e "${ORANGE}╟┤ \033[38;5;142m(  _ \(  _ \ /  \  _(  )(  __)/ __)(_  _)\033[0m ${ORANGE}├╢${NC}"
  echo -e "${ORANGE}╟┤ \033[38;5;142m ) __/ )   /(  O )/ \) \ ) _)( (__   )( \033[0m  ${ORANGE}├╢${NC}"
  echo -e "${ORANGE}╟┤ \033[38;5;142m(__)  (__\_) \__/ \____/(____)\___) (__)\033[0m  ${ORANGE}├╢${NC}"
  echo -e "${ORANGE}╟┤                                           ├╢${NC}"
  echo -e "${ORANGE}╟┼┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┼╢${NC}"
  echo -e "${ORANGE}╚╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╧╝${NC}"

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
    folder_special_use_case="$base_location$default_location"
    # Adding all options in for creating the type of project
    if [[ "$type_project" == "Empty" ]]; then
      mkdir -p "$new_folder"
      cd "$new_folder"
      break
    elif [[ "$type_project" == "Vite" ]]; then
      cd $folder_special_use_case
      npm create vite@latest "$project_name"
      break
    elif [[ "$type_project" == "Java" ]]; then
      cd $folder_special_use_case
      ~/my-setup-scripts/scripts/maven-quickstart.sh "$project_name"
      break
    elif [[ "$type_project" == "Springboot" ]]; then
      cd $folder_special_use_case
      ~/my-setup-scripts/scripts/springboot.sh "$project_name"
      cd "$project_name"
      # Rename gitignore to .gitignore if it exists
      if [ -f "gitignore" ]; then
        echo "Renaming gitignore to .gitignore"
        mv "gitignore" ".gitignore"
        notify-send "gitignore detecetd anc change to .gitignore"
      else
        notify-send ".gitignore was already created"
      fi
      echo "pg_data/" >>.gitignore
      echo "docker-compose.yml" >>.gitignore
      echo ".env" >>.gitignore

      app_properties="src/main/resources/application.properties"

      cat >>"$app_properties" <<EOF
spring.config.import=optional:file:.env[.properties]
spring.sql.init.platform=postgres
spring.datasource.url=jdbc:postgresql://\${POSTGRES_HOST}:\${POSTGRES_PORT}/\${POSTGRES_DB}
spring.datasource.username=\${POSTGRES_USER}
spring.datasource.password=\${POSTGRES_PASSWORD}
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=create
spring.sql.init.mode=always
spring.jpa.defer-datasource-initialization=true
spring.jpa.show-sql=true
logging.level.org.springframework.security=DEBUG
EOF
      cat >.env <<EOF
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=user
POSTGRES_PASSWORD=password
POSTGRES_DB=$project_name
EOF
      cat >Dockerfile <<EOF
# Use an official Maven image to build the application
FROM maven:3.9.8-amazoncorretto-21 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code and build the application
COPY src ./src
RUN mvn clean package -DskipTests

# Use an official Amazon Corretto runtime as a parent image
FROM amazoncorretto:21

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/$project_name-0.0.1-SNAPSHOT.jar app.jar

# Command to run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]

EOF
      cat >docker-compose.yml <<EOF
version: '3.9'

services:

  db:
    container_name: $project_name
    image: postgres
    shm_size: 128mb
    env_file:
      - .env
    ports:
      - "5432:5432"
    volumes:
      - './pg_data:/var/lib/postgresql/data/'
EOF
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
