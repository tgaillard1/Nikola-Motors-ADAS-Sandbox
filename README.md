# Nikola-Motors Google Cloud ADAS Reference Architecture

For the POC deployment you should only have to deploy the first three stages of this repo; project-create, 01a-privatecloud & 01b-network-peering. This will deploy the reference architecture below with only the VPN connection connection remaining.  To begin go to [project-create](./stages/01-privatecloud/project-create). 

<img src="https://github.com/tgaillard1/Nikola-Motors-ADAS-Sandbox/blob/main/docs/NikolaMotors-Sandbox-RA.png" alt="ADAS Architecture"/>

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
