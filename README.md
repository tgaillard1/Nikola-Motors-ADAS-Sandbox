# Nikola-Motors Google Cloud ADAS Reference Architecture

This repository has a build script that will deploy all elements of a reference ADAS architecture to support your training and operational needs.  

<img src="https://github.com/tgaillard1/Nikola-Motors-ADAS-Sandbox/blob/main/docs/NikolaMotors-Sandbox-RA1.png" alt="ADAS Architecture"/>

## Private Cloud Deployment

Follow the steps below:
 * Log into your [Google Cloud Console](https://accounts.google.com/) (GCP)
 p Open Cloud Shell (select the square icon <img src="https://github.com/tgaillard1/Nikola-Motors-ADAS-Sandbox/blob/main/docs/cloud-shell.png" alt="Cloud Shell Icon"/> in the top right of the console)
 * Validate what project you are in on GCP.  An existing project for Nikola -->  prj-rp-Engineering can be used.  If needed run this command to change to an active project, e.g., --> gcloud config set project prj-rp-Enginerring
   
     * Clone git directory into the cloud shell
    
        ```
        git clone https://github.com/tgaillard1/Nikola-Motors-ADAS-Sandbox.git
        ```
     * Change directories to the --> Nikola-Motors-ADAS-Sandbox
    
        ```
        cd ~/Nikola-Motors-ADAS-Sandbox
        ```
     * Run the script --> build.sh

        ```
        ./build.sh
        ```

# Google Cloud ADAS Foundation

This repository contains Terraform code to deploy a sample Terraform foundation for a reference architecture for ADAS. In this repository you can find Terraform modules, deployment examples as well as a set of deployment stages to set up you foundational infrastructure.

## Disclaimer

This is not an officially supported Google product. This code is intended to help users setting up their foundational Infrastructure-as-code deployment for Google Cloud ADAS.

For an end-to-end deployment for a reference architecture for ADAS deploy all stages in this repository. The provided build script will deploy all elements without having to individually execute the stages.

### 01-sandbox-creation
This stage contains the Terraform content to deploy a sandbox private cloud, create a network for a sandbox and enable all API's needed. 

### 02-deployment-data-fusion
This stage deploys data fusion for all integrations and workflows

### 03-deployment-kubernetes-for-training-and-3rd-party-applications
This stage deploys a kubernetes cluster with different node pools to enable standard and AI training

### 04-network-integrations
This stage contains the Terraform content to integrate services withing a single VPC.
