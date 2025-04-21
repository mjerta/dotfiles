#!/usr/bin/env bash

if [[ -z "$1" || -z "$2" ]]; then
  echo "First argument should be the HTTP-method (e.g., GET, POST, PUT, DELETE)"
  echo "Second argument should be the addres you want to test (e.g., http://localhost:8080)"
  exit 1;
fi
if [[ -n "$3" && "$1" == "GET" ]]; then
  echo "Third argument (JSON file) should not be provided for GET requests"
  exit 1;
fi

# Execute request
if [[ "$1" == "GET" || "$1" == "DELETE" ]]; then
  curl -X "$1" "$2"
else
  if [[ -n "$3" ]]; then
    curl -X "$1" "$2" \
      -H "Content-Type: application/json" \
      -d @"$3"
  else
    echo "❗ Missing JSON file for $1 request"
    exit 1
  fi
fi
