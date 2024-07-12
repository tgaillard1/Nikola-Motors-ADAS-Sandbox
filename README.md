# Nikola-Motors Google Cloud ADAS Reference Architecture

For the POC deployment you should only have to deploy the first three stages of this repo; project-create, 01a-privatecloud & 01b-network-peering. This will deploy the reference architecture below with only the VPN connection connection remaining.  To begin go to [project-create](./stages/01-privatecloud/project-create). 

<img src="https://github.com/tgaillard1/Nikola-Motors-ADAS-Sandbox/blob/main/docs/NikolaMotors-Sandbox-RA.png" alt="ADAS Architecture"/>

# Google Cloud ADAS Foundation

This repository contains Terraform code to deploy a sample Terraform foundation for a reference architecture for ADAS. In this repository you can find Terraform modules, deployment examples as well as a set of deployment stages to set up you foundational infrastructure.

## Disclaimer

This is not an officially supported Google product. This code is intended to help users setting up their foundational Infrastructure-as-code deployment for Google Cloud ADAS.

## Structure

The repository has the following structure
```
├── modules
│   ├── nsxt-gateway-firewall
│   ├── nsxt-load-balancer-pool
│   ├── nsxt-load-balancer-service
│   ├── ...
└── stages
    ├── 01-privatecloud
    ├── 02a-nsxt
    ├── 02b-vcenter
    ├── 03-vms
    └── 04-load-balancing
```

 * `examples` contains modular example deployments for each individual module that this repository provides.
 * `modules` contains all modules that are used in the deployment stages.
 * `stages` contains sample deployments for different stages of the foundational deployment which should be executed in the order they are listed.

## Deployment Stages

For an end-to-end deployment of the GCVE IaC Foundation deploy all stages in this repository in the given order. Should you only be interested in a particular use case (e.g. NSX-T management) you can deploy this stage in isolation as long the necessary prerequisites exist (e.g. Private Cloud has been deployed).

The stages are separated by the management component they interact with (Google Cloud, NSX-T, vCenter) as well as the Terraform provider that they are using. The stages are also suggested as an ordered sequence of deployment tasks (e.g. deploy vCenter folder hierarchy as a prerequisite for application VM deployments).

### 01-privatecloud
This stage contains the Terraform content to deploy a private cloud and configure the integration with Cloud Monitoring.

### 02a-
This stage contains the Terraform content for a foundational NSX-T setup (segments, firewalls). This stage can be deployed in parallel with stage `02b-vcenter`.

### 02b-
This stage contains the Terraform content for a foundational vCenter setup (folders, resource pools, roles). This stage can be deployed in parallel with stage `02a-nsxt`.

### 03-
This stage contains the Terraform content for deploying VMs into vCenter.

### 04-network-integrations
This stage contains the Terraform content to deploy load balancers for the previously created VMs.


## Modules

The stages and examples in this repository use modules in the `modules` directory. You can reuse the modules individually:

 * [GCVE Monitoring](./modules/gcve-monitoring)
 * [GCVE Private Cloud](./modules/gcve-private-cloud)
 * [GCVE Service Networking](./modules/gcve-service-networking)
 * [NSX-T Distributed Firewall Manager](./modules/nsxt-distributed-firewall-manager)
 * [NSX-T Distributed Firewall Policy](./modules/nsxt-distributed-firewall-policy)
