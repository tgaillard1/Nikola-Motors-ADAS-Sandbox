# VM Stage

## Use Cases

In this stage you create VMs in vCenter.

Use the `terraform.tfvars.example` file as a template to populate the variables to deploy multiple VMs.

## Prerequisites

 * Private Cloud is already deployed and accessible
 * Roles and identities which are assigned to resource pools and folders need to exist before executing this stage
 * Folder and Resource Pool should be deployed and permissions should be configured

## Instructions

To deploy this stage from a local UNIX shell, follow the steps:
 * Rename (or copy) the file `terraform.tfvars.example` to `terraform.tfvars` and fill in suitable variables for your environment.
 * Supply variables related to your GCVE vSphere environment:
   * `export TF_VAR_vsphere_server=vcsa-123456.abcdef01.asia-southeast1.gve.goog`
   * `export TF_VAR_vsphere_user=CloudOwner@gve.local`
   * `export TF_VAR_vsphere_password=.......`
 * Initialize Terraform: `terraform init`
 * Validate the resources created by Terraform: `terraform plan`
 * Apply Terraform configurations: `terraform apply`

## Dependencies

 * modules/vcenter-vm