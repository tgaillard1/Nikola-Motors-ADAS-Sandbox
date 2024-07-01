# U-Haul POC Private Cloud

## Private Cloud Deployment

Follow the steps below:
 * Log into your Google Cloud Platform (GCP)
 * Open Cloud Shell (select the square icon <img src="https://github.com/tgaillard1/Uhaul-gcve-iac-foundations/blob/main/docs/cloud-shell.png" alt="Cloud Shell Icon"/> in the top right of the console)
        ```
     * Run the following command to change to the project you just created, e.g.,  --> gcve-uhaul-pilot2024
    
        ```
        gcloud config set project gcve-uhaul-pilot-2024
        ```
     * Enable the GCP API's to perform the terraform actions
    
        ```
        gcloud services enable \
        compute.googleapis.com \
        iam.googleapis.com \
        cloudresourcemanager.googleapis.com \
        iamcredentials.googleapis.com \
        monitoring.googleapis.com \
        logging.googleapis.com \
        serviceusage.googleapis.com \
        cloudbilling.googleapis.com \
        vmwareengine.googleapis.com
        ```
     * Change directories to the --> 01a-privatecloud
    
        ```
        cd ~/Uhaul-gcve-iac-foundations/stages/01-privatecloud/01a-privatecloud/
        ```
     * Copy --> terraform.tfvars.example to --> terraform.tfvars
    
        ```
        cp terraform.tfvars.example terraform.tfvars
        ```
     * Validate any variables you might want to change.  The project needs to be the same as the previous stage.  If updates are needed change --> terraform.tfvars file
    
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

## Troubleshooting

 * Occassionaly the terraform apply command fails within the first few minutes do to a race condition.  If this occurs simply rerun the terraform apply command and it should resume and complete the operations.

## Next steps

 * Proceed to the second module --> [01b-network-peering](../01b-network-peering).

