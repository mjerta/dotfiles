#!/bin/bash

SUBNET="192.168.1"
TOTAL=254

echo "Scanning subnet $SUBNET.0/24 for HTTP interfaces..."

for i in $(seq 1 $TOTAL); do
  printf "\rScanning %d/%d: %s.%d" "$i" "$TOTAL" "$SUBNET" "$i"

  # Add --max-time to prevent hanging
  if curl -s --connect-timeout 1 --max-time 3 "http://$SUBNET.$i/" -o /dev/null; then
    echo -e "\nFound HTTP interface at $SUBNET.$i"
  fi
done

echo -e "\nScan complete."
