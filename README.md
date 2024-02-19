# tf-gcp-infra

## Prerequisites
1. Download Terraform v1.7.3 or above
2. Perform gcloud user authentication using ```gcloud auth login```
3. Generate application default credentials to allow Terraform to access your gcp services using ```gcloud auth application-default login```
4. Set your project using ```gcloud config set project <YOUR_PROJECT_ID>```
5. Enable the following GCP Service APIs
    - Compute Engine API
6. Create your custom application image for your webapp and provide an image family name to it
7. Setup following terraform environment variables in project directory using a "tfvars" file
    - project_id - ID of your gcp project
    - vpc_name - Name of your vpc
    - vpc_routing_mode - Routing mode for your vpc
    - webapp_subnet_name - Name of your webapp subnet
    - webapp_subnet_cidr - webapp subnet IP address range in CIDR
    - webapp_subnet_region - Region of webapp subnet
    - webapp-allow-http-firewall_name - Name of http firewall applied on your webapp subnet
    - webapp_http_port - port of your webapp application to be accessed from internet
    - webapp_allow_http_tag - acts as target tag and network tag for your webapp-allow-http-firewall firewall and webapp instance respectively 
    - webpp_instance_name - webapp instance name
    - webapp_machine_type - webapp instance machine type
    - webapp_instance_zone - webapp instance zone
    - webapp_instance_disk_size - webapp instance disk size
    - webapp_instance_disk_type - webapp instance disk type
    - webapp_image_family - family name of the application image you created for your webapp
    - db_subnet_name - Name of your db subnet
    - db_subnet_cidr - db subnet IP address range in CIDR
    - db_subnet_region - Region of db subnet
    - webapp_default_route_name - Name of webapp catch-all route (0.0.0.0/0)

## Instructions
1. Initialize terraform using ```terraform init```
2. Check the changes the template will apply using ```terraform plan -var-file=<YOUR_TFVARS_FILE>```
3. Apply the changes using ```terraform apply -var-file=<YOUR_TFVARS_FILE>```
