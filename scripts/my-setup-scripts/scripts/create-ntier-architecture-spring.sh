#!/usr/bin/env bash


if [[ -z "$1" ]]; then
    echo "Error: No argument provided."
    exit 1
  else
    cd src/main/java || exit
    cd "$(ls -d */ | head -n 1)" || exit
    cd "$(ls -d */ | head -n 1)" || exit
    project_name=$(ls -d */ | head -n 1)
    project_name="${project_name%/}"
    cd $project_name || exit
    mkdir -p "./controllers" "./repositories" "./services" "./models"
    touch "./controllers/$1Controller.java"
    touch "./repositories/$1Repository.java"
    touch "./services/$1Service.java"
    touch "./models/$1.java"
    

    cat <<EOF > "models/$1.java"
package nl.mpdev.${project_name,,}.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "${1,,}s")
public class $1 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
}
EOF
        


    
fi
