#!/usr/bin/env bash

# Define options
options[1]='screen'
options[2]='ebook'
options[3]='printer'
options[4]='prepress'
options[5]='default'

# Display options
options_string=''
for key in "${!options[@]}"; do
  options_string+="Press $key for ${options[$key]}\n"
done
echo -n -e "$options_string"

# Read user choice
read -rsn1 options_choise

# Validate user choice
if [[ -z "${options[$options_choise]}" ]]; then
  echo "Invalid choice. Exiting."
  exit 1
fi

# Select input file
input_file=$(fzf --prompt="Select a file: ")
if [[ -z "$input_file" ]]; then
  echo "No file selected. Exiting."
  exit 1
fi

# Read output file name
read -p "Enter output file name: " output_string

# Check if output file name is provided
if [[ -z "$output_string" ]]; then
  echo "No output file name provided. Exiting."
  exit 1
fi

# Compress PDF
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/${options[$options_choise]} \
  -dNOPAUSE -dQUIET -dBATCH \
  -sOutputFile="$output_string.pdf" "$input_file"

# Check if gs command was successful
if [[ $? -eq 0 ]]; then
  echo "PDF compression successful. Output file: $output_string.pdf"
else
  echo "PDF compression failed."
  rm -f "$output_string.pdf"
  exit 1
fi

