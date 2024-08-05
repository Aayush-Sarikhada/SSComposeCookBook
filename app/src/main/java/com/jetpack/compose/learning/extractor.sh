#!/bin/bash

# Function to search for files and extract line numbers
search_files() {
  local folder=$1
  local pattern=${2:-*Activity*}

  # Find files with "Activity" suffix in the specified folder and its subfolders
  find "$folder" -type f -name "$pattern" | while read -r file; do
    # Check if the file contains "MainContent()"
    if grep -q "fun MainContent(" "$file"; then
      # Extract and print line numbers with "MainContent()"
      grep -n "fun MainContent(" "$file" | while IFS=: read -r line_number _; do
        echo "<a src=\"/app/src/main/java/com/jetpack/compose/learning/${file#$folder/}#L$line_number\">"
      done
      echo ""
    fi
  done
}

# Check if the folder argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <folder>"
  exit 1
fi

# Call the search function with the specified folder
search_files "$1"
