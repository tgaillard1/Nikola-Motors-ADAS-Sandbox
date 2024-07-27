#!/bin/bash

# Prompt the user for the project_id
read -p "Enter the project_id: " project_id

# Find the line in variables.tf that contains "project_id"
line_number=$(grep -n 'project_id' variables.tf | cut -d: -f1)

echo "$line_number"
echo "$project_id"

# If the line is found, replace the existing value with the new one
if [ -n "$line_number" ]; then
  grep -q 'project_id' variables.tf && sed -i "s/project_id/$project_id/g" variables.tf
  echo "Successfully updated project_id in variables.tf"
else
  echo "project_id not found in variables.tf"
fi

