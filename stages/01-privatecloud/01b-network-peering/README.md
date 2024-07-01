# U-Haul POC Private Cloud

## Network Peering

Follow the steps below:
 * Log into your Google Cloud Platform (GCP)
 * Open Cloud Shell (select the square icon <img src="https://github.com/tgaillard1/Uhaul-gcve-iac-foundations/blob/main/docs/cloud-shell.png" alt="Cloud Shell Icon"/> in the top right of the console)
     * Change directories to the --> 01b-privatecloud stage
    
        ```
        cd ~/Uhaul-gcve-iac-foundations/stages/01-privatecloud/01b-network-peering/
        ```
     * Copy --> terraform.tfvars.example to --> terraform.tfvars
    
        ```
        cp terraform.tfvars.example terraform.tfvars
        ```
     * No changes are needed unless you changed the project name or foundational network name in the 01a-privatecloud stage.  If you did change values update the --> terraform.tfvars file with your new information
    
        ```
        vi terraform.tfvars
        ```
     * Execture the following terraform commands to initiate the deployment
    
        ```
        terraform init
        ```
        ```
        terraform plan
        ```
        ```
        terraform apply
        ```