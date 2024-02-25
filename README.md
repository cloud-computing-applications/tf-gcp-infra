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
    - deny_all_firewall_name - Name of deny all firewall applied on the vpc
    - deny_all_firewall_direction - Direction of traffic to which the firewall applies
    - deny_all_firewall_source_range - source IP range for which the firewall applies
    - deny_all_firewall_destination_range - destination IP range for which the firewall applies
    - deny_all_firewall_protocol - protocol on which the firewall denies traffic
    - deny_all_firewall_priority - priority of the deny_all firewall
    - webapp-allow-http-firewall_name - Name of http firewall applied on your webapp subnet
    - webapp_allow_http_firewall_direction - Direction of traffic to which the firewall applies
    - webapp_tcp_port - port of your webapp application to be accessed from internet
    - webapp_allow_http_tag - acts as target tag and network tag for your webapp-allow-http-firewall firewall and webapp instance respectively
    - webapp_allow_http_source_range - source IP range for which the firewall applies
    - webapp_allow_http_protocol - protocol on which the firewall allows traffic
    - webapp_allow_http_priority - priority of the webapp-allow-http firewall
    - webpp_instance_name - webapp instance name
    - webapp_machine_type - webapp instance machine type
    - webapp_instance_zone - webapp instance zone
    - webapp_instance_disk_size - webapp instance disk size
    - webapp_instance_disk_type - webapp instance disk type
    - webapp_image_family - family name of the application image you created for your webapp
    - webapp_startup_script_path - path to the start up script that will run on webapp instance
    - db_subnet_name - Name of your db subnet
    - db_subnet_cidr - db subnet IP address range in CIDR
    - db_subnet_region - Region of db subnet
    - webapp_default_route_name - Name of webapp catch-all route
    - webapp_default_route_dest_range - destination IP range of the route
    - webapp_default_route_next_hop_gateway - next hop gateway of the route
    - db_ps_ip_range_address_name - Name for the IP range address allocated for private access to MySQL database
    - db_ps_ip_range_address_type - Type of the IP range address allocated for private access to MySQL database
    - db_ps_ip_range_address_purpose - Purpose of the IP range address allocated for private access to MySQL database
    - db_ps_ip_range_address_first_ip - First IP address in the range for private access to MySQL database
    - db_ps_ip_range_address_prefix_length - Prefix length for the IP address range allocated for private access to MySQL database
    - db_ps_connection_deletion_policy - Deletion policy for the private service connection to MySQL database
    - db_ps_connection_service - Service for the private service connection to MySQL database
    - db_instance_name - Name for the Google Cloud SQL database instance
    - db_instance_database_version - Database version for the Google Cloud SQL instance
    - db_instance_region - Region for the Google Cloud SQL instance
    - db_instance_deletion_protection - Whether deletion protection is enabled for the Google Cloud SQL instance
    - db_instance_tier - Tier for the Google Cloud SQL instance
    - db_instance_availability_type - Availability type for the Google Cloud SQL instance
    - db_instance_edition - Edition for the Google Cloud SQL instance
    - db_instance_disk_type - Disk type for the Google Cloud SQL instance
    - db_instance_disk_size - Disk size for the Google Cloud SQL instance
    - db_instance_ipv4_enabled - Whether IPv4 is enabled for the Google Cloud SQL instance
    - db_instance_enable_private_path_for_google_cloud_services - Whether private IP access is enabled for the Google Cloud SQL instance
    - db_instance_backup_configuration_enabled - Whether backup configuration is enabled for the Google Cloud SQL instance
    - db_instance_binary_log_enabled - Whether binary logging is enabled for the Google Cloud SQL instance
    - db_user_name - Username for the database user
    - application_port - Port used by the application
    - database_name - Name of the MySQL database
    - deny_all_db_firewall_name - Name for the firewall rule denying all traffic to the MySQL database
    - deny_all_db_firewall_direction - Direction of traffic for the firewall rule denying all traffic to the MySQL database
    - deny_all_db_firewall_source_range - Source IP range for the firewall rule denying all traffic to the MySQL database
    - deny_all_db_firewall_priority - Priority of the firewall rule denying all traffic to the MySQL database
    - deny_all_db_firewall_protocol - Protocol for the firewall rule denying all traffic to the MySQL database
    - allow_db_firewall_name - Name for the firewall rule allowing specific traffic to the MySQL database
    - allow_db_firewall_direction - Direction of traffic for the firewall rule allowing specific traffic to the MySQL database
    - allow_db_http_tag - HTTP tag for the firewall rule allowing specific traffic to the MySQL database
    - allow_db_firewall_priority - Priority of the firewall rule allowing specific traffic to the MySQL database
    - allow_db_firewall_protocol - Protocol for the firewall rule allowing specific traffic to the MySQL database
    - allow_db_tcp_port - TCP port for the firewall rule allowing specific traffic to the MySQL database

## Instructions
1. Initialize terraform using ```terraform init```
2. Check the changes the template will apply using ```terraform plan -var-file=<YOUR_TFVARS_FILE>```
3. Apply the changes using ```terraform apply -var-file=<YOUR_TFVARS_FILE>```
