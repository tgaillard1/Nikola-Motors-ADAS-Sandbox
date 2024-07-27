#!/usr/bin/env bash

# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Verify that the scripts are being run from Linux and not Mac
if [[ $OSTYPE != "linux-gnu" ]]; then
    echo "ERROR: This script and consecutive set up scripts have only been tested on Linux. Currently, only Linux (debian) is supported. Please run in Cloud Shell or in a VM running Linux".
    exit;
fi

#Enable core project API's

echo "Enabling core project API's for project creation..."

gcloud services enable cloudresourcemanager.googleapis.com \
  compute.googleapis.com \
  iam.googleapis.com \
  iamcredentials.googleapis.com \
  monitoring.googleapis.com \
  logging.googleapis.com \
  serviceusage.googleapis.com \
  cloudbilling.googleapis.com 

echo "Change to project folder and copy template to update variables"
cd stages/01-privatecloud/project-create/
cp terraform.tfvars.example terraform.tfvars

# Prompt the user to enter variables
read -p "Enter a Project ID: " project_id
read -p "Enter a Billing ID:" billing_id
read -p "Endter base CIDR range, e.g., 10.10.0.0/22:" basecidrrange
read -p "Endter private cloud CIDR range, e.g., 10.0.0.0/22:" mypccidrrange

# Check if terraform.tfvars exists
# if [ ! -f "terraform.tfvars" ]; then
#     echo "File 'terraform.tfvars' not found. Creating a new one."
#     echo "project=\"$project_id\"" > terraform.tfvars
#      echo "billing_id=\"$billing_id\"" >> terraform.tfvars
#    echo "File 'terraform.tfvars' created and updated successfully."
#    exit 0
# fi

# Read existing variables from terraform.tfvars
while IFS='=' read -r key value; do
    if [ "$key" == "project" ]; then
        value=\"$project_id\"  # Update project id if found
    elif [ "$key" == "billing_id" ]; then
    value=\"$billing_id\" 
    fi 
    variables+=("$key=$value")  # Store key-value pair
done < terraform.tfvars

# Write updated variables back to terraform.tfvars
printf '%s\n' "${variables[@]}" > terraform.tfvars

echo "File 'terraform.tfvars' updated successfully."

# terraform init
# terraform apply

echo "Change to new project -- $project_id"
gcloud config set project $project_id

echo "Changing directories to create new services and network"
cd ../../../modules/google-data-fusion/

echo "Enabling new project API's to create services ..."
gcloud services enable \
compute.googleapis.com \
iam.googleapis.com \
cloudresourcemanager.googleapis.com \
iamcredentials.googleapis.com \
monitoring.googleapis.com \
logging.googleapis.com \
serviceusage.googleapis.com \
cloudbilling.googleapis.com \
datafusion.googleapis.com

# Create network
echo "Create the VPC for sandox environment"

gcloud compute networks create nikola-sandbox-network --subnet-mode=custom

cp variables.tf.example variables.tf

# Read existing variables from variables.tf
# Find the line in variables.tf that contains "project_id"
line_number=$(grep -n 'project_id' variables.tf | cut -d: -f1)

# If the line is found, replace the existing value with the new one
if [ -n "$line_number" ]; then
  grep -q 'project_id' variables.tf && sed -i "s/project_id/$project_id/g" variables.tf
  echo "Successfully updated project_id in variables.tf"
else
  echo "project_id not found in variables.tf"
fi

echo "File 'variables.tf' for data fustion updated successfully."

# Create data fusion
echo "Create data fusion environment"

# terraform init
# terraform apply

