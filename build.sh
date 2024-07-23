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

echo "Enabling core pooject API's for project creation..."

gcloud services enable cloudresourcemanager.googleapis.com \
  compute.googleapis.com \
  iam.googleapis.com \
  iamcredentials.googleapis.com \
  monitoring.googleapis.com \
  logging.googleapis.com \
  serviceusage.googleapis.com \
  cloudbilling.googleapis.com \
  vmwareengine.googleapis.com

echo "Change to project folder and copy template to update variables"
cd stages/01-privatecloud/project-create/
cp terraform.tfvars.example terraform.tfvars

# Prompt the user to enter variables
read -p "Enter a Project ID: " project_id
read -p "Enter a Billind ID:" billing_id

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "File 'terraform.tfvars' not found. Creating a new one."
    echo "project=\"$project_id\"" > terraform.tfvars
    echo "billing_id=\"$billing_id\"" >> terraform.tfvars
    echo "File 'terraform.tfvars' created and updated successfully."
    exit 0
fi

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

terraform init
terraform apply
