#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  echo "Error: No argument provided."
  exit 1
else
  cd src/main/java || exit
  domain_suffix="$(ls -d */ | head -n 1)"
  domain_suffix=${domain_suffix%/}  
  cd "$domain_suffix" || exit
  domain_name=$(ls -d */ | head -n 1)
  domain_name=${domain_name%/}
  cd "$domain_name" || exit
  project_name=$(ls -d */ | head -n 1)
  project_name="${project_name%/}"
  cd $project_name || exit

  mkdir -p "./controllers" "./repositories" "./services" "./models"
  touch "./controllers/$1Controller.java"
  touch "./repositories/$1Repository.java"
  touch "./services/$1Service.java"
  touch "./models/$1.java"

  cat <<EOF >"models/$1.java"
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
public class ${1} {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
}
EOF
  cat << EOF >"repositories/$1Repository.java"
package ${domain_suffix}.${domain_name}.${project_name}.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import ${domain_suffix}.${domain_name}.${project_name,,}.models.${1};

public interface ${1}Repository extends JpaRepository<${1}, Long> {
}
EOF

  cat << EOF >"services/$1Service.java"
package ${domain_suffix}.${domain_name}.${project_name,,}.services;

import org.springframework.stereotype.Service;
import nl.mpdev.${project_name,,}.models.${1};
import nl.mpdev.${project_name,,}.repositories.${1}Repository;

@Service
public class ${1}Service {

  private final ${1}Repository ${1,,}Repository;

  public ${1}Service(${1}Repository ${1,,}Repository) {
    this.${1,,}Repository = ${1,,}Repository;
  }
}
EOF
  cat << EOF >"controllers/$1Controller.java"
package ${domain_suffix}.${domain_name}.${project_name}.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ${domain_suffix}.${domain_name}.${project_name,,}.models.${1};
import ${domain_suffix}.${domain_name}.${project_name,,}.services.${1}Service;

@RestController
@CrossOrigin(value = "http://localhost:5173")
@RequestMapping("/api/v1")
public class ${1}Controller {

private final ${1}Service ${1,,}Service;

  public ${1}Controller(${1}Service ${1,,}Service) {
    this.${1,,}Service = ${1,,}Service;
  }
}

EOF
fi
