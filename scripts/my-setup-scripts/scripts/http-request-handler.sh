#!/usr/bin/env bash

# Check for required arguments
if [[ -z "$1" || -z "$2" ]]; then
  echo "First argument should be the HTTP method (e.g., GET, POST, PUT, DELETE)"
  echo "Second argument should be the address you want to test (e.g., http://localhost:8080)"
  exit 1
fi

# Disallow JSON file for GET
if [[ -n "$3" && "$1" == "GET" ]]; then
  echo "Third argument (JSON file) should not be provided for GET requests"
  exit 1
fi

# Perform request
if [[ "$1" == "GET" || "$1" == "DELETE" ]]; then
  curl -s -X "$1" "$2" -w "\nHTTP Status: %{http_code}\n"
else
  if [[ -n "$3" ]]; then
    curl -s -X "$1" "$2" \
      -H "Content-Type: application/json" \
      -d @"$3" \
      -w "\nHTTP Status: %{http_code}\n"
  else
    echo "❗ Missing JSON file for $1 request"
    exit 1
  fi
fi


