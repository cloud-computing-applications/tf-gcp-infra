# tf-gcp-infra

## Prerequisites
1. Download Terraform v1.7.3 or above
2. Perform gcloud user authentication using ```gcloud auth login```
3. Generate application default credentials to allow Terraform to access your gcp services using ```gcloud auth application-default login```
4. Set your project using ```gcloud config set project <YOUR_PROJECT_ID>```
5. Enable the following GCP Service APIs
    - Compute Engine API
    - Service Networking API
    - Cloud DNS API
    - Cloud Logging API
    - Cloud Monitoring API
    - Cloud Build API
    - Cloud Functions API
    - Cloud Pub/Sub API
    - Eventarc API
    - Cloud Run Admin API
    - Serverless VPC Access API
6. Create your custom application image for your webapp and provide an image family name to it
7. Setup following terraform environment variables in project directory using a "tfvars" file
    - Project and vpc
      - project_id - ID of your gcp project
      - vpc_name - Name of your vpc
      - vpc_routing_mode - Routing mode for your vpc
    
    - Webapp subnet
      - webapp_subnet_name - Name of your webapp subnet
      - webapp_subnet_cidr - webapp subnet IP address range in CIDR
      - webapp_subnet_region - Region of webapp subnet

    - Deny all firewall
      - deny_all_firewall_name - Name of deny all firewall applied on the vpc
      - deny_all_firewall_direction - Direction of traffic to which the firewall applies
      - deny_all_firewall_source_range - source IP range for which the firewall applies
      - deny_all_firewall_destination_range - destination IP range for which the firewall applies
      - deny_all_firewall_protocol - protocol on which the firewall denies traffic
      - deny_all_firewall_priority - priority of the deny_all firewall

    - DB subnet
      - db_subnet_name - Name of your db subnet
      - db_subnet_cidr - db subnet IP address range in CIDR
      - db_subnet_region - Region of db subnet
  
    - Webapp catch all route
      - webapp_default_route_name - Name of webapp catch-all route
      - webapp_default_route_dest_range - destination IP range of the route
      - webapp_default_route_next_hop_gateway - next hop gateway of the route

    - DB private service ip range allocation
      - db_ps_ip_range_address_name - Name for the IP range address allocated for private access to MySQL database
      - db_ps_ip_range_address_type - Type of the IP range address allocated for private access to MySQL database
      - db_ps_ip_range_address_purpose - Purpose of the IP range address allocated for private access to MySQL database
      - db_ps_ip_range_address_first_ip - First IP address in the range for private access to MySQL database
      - db_ps_ip_range_address_prefix_length - Prefix length for the IP address range allocated for private access to MySQL database

    - DB private service
      - db_ps_connection_deletion_policy - Deletion policy for the private service connection to MySQL database
      - db_ps_connection_service - Service for the private service connection to MySQL database

    - DB instance
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

    - DB create user and database
      - db_password_length - length of mysql database user's password to be generated
      - db_password_special - Whether to include special characters in the password
      - db_password_override_special - String of special characters used for generating password
      - db_user_name - Username for the database user
      - database_name - Name of the MySQL database

    - Webapp Environment variables
      - application_port - Port used by the application
      - environment - The environment of the application (DEVELOPMENT, TEST, PRODUCTION)
      - log_file_path - Path of the log file where the application will dump it's logs (Not used for TEST Environment)
      - EXPIRY_BUFFER - Amount of time after which the verification link will expire (in seconds)

    - Deny all traffic to db instance firewall
      - deny_all_db_firewall_name - Name for the firewall rule denying all traffic to the MySQL database
      - deny_all_db_firewall_direction - Direction of traffic for the firewall rule denying all traffic to the MySQL database
      - deny_all_db_firewall_source_range - Source IP range for the firewall rule denying all traffic to the MySQL database
      - deny_all_db_firewall_priority - Priority of the firewall rule denying all traffic to the MySQL database
      - deny_all_db_firewall_protocol - Protocol for the firewall rule denying all traffic to the MySQL database
    
    - Allow traffic to db instance firewall
      - allow_db_firewall_name - Name for the firewall rule allowing specific traffic to the MySQL database
      - allow_db_firewall_direction - Direction of traffic for the firewall rule allowing specific traffic to the MySQL database
      - allow_db_http_tag - HTTP tag for the firewall rule allowing specific traffic to the MySQL database
      - allow_db_firewall_priority - Priority of the firewall rule allowing specific traffic to the MySQL database
      - allow_db_firewall_protocol - Protocol for the firewall rule allowing specific traffic to the MySQL database
      - allow_db_tcp_port - TCP port for the firewall rule allowing specific traffic to the MySQL database
    
    - Webapp DNS Zone
      - dns_zone_name - Name of DNS zone you created for webapp
      - webapp_a_rs_type - A record type for webapp load balancer (should be "A")
      - webapp_a_rs_ttl - Time to live for the A record

    - Service account for webapp instance
      - webapp_service_account_name - Service account name to be created and used for webapp instance
      - webapp_service_account_description - Description of service account used for webapp instance
      - webapp_service_account_permissions - Comma seperated string containing the roles for service account that is used for webapp instance
    
    - Pub/Sub Topic Schema for email verification
      - topic_schema_name - Name of the topic schema
      - topic_schema_type - Schema type (use "AVRO" for provided schema)
      - topic_schema_definition = Path to file containing topic schema definition
    
    - Pub/Sub Topic for email verification
      - topic_name - Name of Topic
      - topic_message_retention_duration - retention period of topic messages in seconds (eg. "604800s")
      - topic_schema_encoding - Encoding of topic schema used for this topic (use "JSON" for provided schema)
    
    - Subscription Service Account Creation
      - subscription_service_account_id - Id of subscription service account
      - subscription_service_account_name - Display name of subscription service account

    - Cloud function Service Account Creation
      - cloud_function_service_account_id - Id of Cloud function service account
      - cloud_function_service_account_name - Display name of Cloud function service account
    
    - Google Storage Bucket
      - bucket_name_prefix_random_byte_length - length of random prefix for bucket name
      - bucket_name_postfix - bucket postfix name
      - bucket_storage_class - bucket storage class
      - bucket_location - location of storage bucket
      - bucket_uniform_level_access - Wheather uniform level access is enabled for bucket
      - bucket_force_destroy - Wheather force destroy is enabled for bucket

    - Archiving code for Serverless
      - archive_file_type - type of archieve file (use "zip")
      - archive_file_output_path - output path of generated archieve file
      - archive_file_source_dir - source directory path using which the archieve file is generated
      - bucket_object_name - Name of the object which will be used as source for cloud function
    
    - VPC Connector for cloud function to allow DB interaction
      - db_vpc_connector_name - Name of vpc connector
      - db_vpc_connector_ip_range - IP range for vpc connector in your vpc (should be /28)
      - db_vpc_connector_machine_type - machine type for vpc connector
      - db_vpc_connector_min_instances - minimum number of connector instances
      - db_vpc_connector_max_instances - maximum number of connector instances
      - db_vpc_connector_region - region of vpc connector
    
    - Firewall to allow DB access from cloud functions
      - allow_db_firewall_cf_name - Name of the firewall
      - allow_db_firewall_cf_direction - Direction of the firewall (use "EGRESS")
      - allow_db_firewall_cf_priority  = Priority of the firewall
     
    - Cloud Function Gen 2
      - cloud_function_name - Name of cloud function
      - cloud_function_location - Region of cloud function
      - cloud_function_runtime - Runtime of cloud function
      - cloud_function_entry_point - Entry point of cloud function
      - cloud_function_timeout_seconds - Cloud function timeout in seconds
      - cloud_function_memory - Memory allocated to cloud function
      - cloud_function_cpu - Cpu allocated to cloud function
      - cloud_function_all_traffic_latest - Whether 100% of traffic is routed to the latest revision
      - cloud_function_ingress_settings - cloud function ingress setting
      - cloud_function_min_instances - minimum number of cloud function instances
      - cloud_function_max_instances - maximum number of cloud function instances
      - cloud_function_vpc_egress_settings - egress setting for the vpc connector attached to this cloud function
      - cloud_function_event_trigger_region - region for the trigger of the cloud function
      - cloud_function_event_trigger_event_type - event trigger type for the cloud function
      - cloud_function_event_trigger_retry_policy - retry policy of the trigger 

    - Cloud Function Environment variables
      - SEND_GRID_KEY - SendGrid API Key
      - SEND_GRID_FROM - Sender of the verification mail
      - SEND_GRID_TEMPLATE_ID - Id of the template created on  
      - DOMAIN_PROTOCOL - Protocol for your domain (http or https)
      - DOMAIN_NAME - Domain name

    - Role Bindings
      - subscription_service_account_binding_role_for_cf - Role to be bound to subscription service account for cloud function resource
      - subscription_service_account_binding_role_for_topic - Role to be bound to subscription service account for topic resource
      - webapp_service_account_binding_role - Role to be bound to webapp serice account for the created topic resource

    - Webapp allow health check firewall
      - webapp_allow_hc_firewall_name - Name of http firewall applied on your webapp instances
      - webapp_allow_hc_firewall_direction - Direction of traffic to which the firewall applies
      - webapp_allow_hc_tag - target tag for your firewall to be used by webapp instances
      - webapp_allow_hc_source_range_1 - 1st source IP range Google Cloud health checking systems
      - webapp_allow_hc_source_range_2 - 2nd source IP range Google Cloud health checking systems
      - webapp_allow_hc_protocol - protocol on which the firewall allows traffic
      - webapp_allow_hc_priority - priority of the firewall

    - Webapp instance template
      - webpp_instance_template_name - webapp instance name
      - webapp_machine_template_type - webapp instance machine type
      - webapp_instance_disk_template_size - webapp instance disk size
      - webapp_instance_disk_template_type - webapp instance disk type
      - webapp_instance_template_is_boot_disk - Whether the disk is boot disk
      - webapp_instance_template_auto_delete_disk - Whether to auto delete the disk
      - webapp_instance_template_can_ip_forward - Whether webapp instance can ip forward
      - webapp_instance_template_provisioning_model - provisioning model for webapp instance
      - webapp_instance_template_automatic_restart - Whether the instance should be automatically restarted if it is terminated by Compute Engine
      - webapp_instance_template_on_host_maintenance - Maintenance behavior for webapp instance
      - webapp_image_family - family name of the application image you created for your webapp
      - webapp_service_account_scopes - Comma seperated string containing scopes provided to the webapp instance
      - webapp_startup_script_path - path to the start up script that will run on webapp instance

    - Webapp health check for IGM
      - webapp_health_check_igm_name - Name of webapp health check
      - webapp_health_check_igm_interval - check interval for health check
      - webapp_health_check_igm_timeout - timeout for health check
      - webapp_health_check_igm_healthy_threshold - healthy threshold for health check
      - webapp_health_check_igm_unhealthy_threshold - unhealthy threshold for health check
      - webapp_health_check_igm_request_path - request path for health check 
    
    - Webapp health check for LB
      - webapp_health_check_lb_name - Name of webapp health check
      - webapp_health_check_lb_interval - check interval for health check
      - webapp_health_check_lb_timeout - timeout for health check
      - webapp_health_check_lb_healthy_threshold - healthy threshold for health check
      - webapp_health_check_lb_unhealthy_threshold - unhealthy threshold for health check
      - webapp_health_check_lb_request_path - request path for health check
    
    - Webapp instance group manager
      - webapp_igm_name - name of webapp instance group manager
      - webapp_igm_base_instance_name - name of base instance of webapp instance group manager
      - webapp_igm_distribution_policy_zones - comma seperated string containing the distribution policy zones for webapp instance group manager
      - webapp_igm_distribution_policy_target_shape - distribution policy target shape for webapp instance group manager
      - webapp_igm_update_policy_type - update policy type
      - webapp_igm_instance_redistribution_type - instance redistribution type (use "NONE" for "BALANCED" policy target shape)
      - webapp_igm_update_policy_minimal_action - minimal action of update policy
      - webapp_igm_force_update_on_repair - Whether to force update the configurations on repair 
      - webapp_igm_default_action_on_failure - default action on failure
      - webapp_igm_named_port_name - name of the named port
      - webapp_igm_hc_inital_delay - initial health check delay after machine initialization
    
    - Webapp auto scaler
      - webapp_auto_scaler_name - name of auto scaler
      - webapp_auto_scaler_max_replicas - maximum replicas
      - webapp_auto_scaler_min_replicas - minimum replicas
      - webapp_auto_scaler_cooldown_period - The number of seconds that the autoscaler should wait before it starts collecting information from a new instance.
      - webapp_auto_scaler_mode - auto scaling mode
      - webapp_auto_scaler_cpu_target - target cpu utilization after which resources are scaled up
      - webapp_auto_scaler_predictive_method - predictive scaling method
      - webapp_auto_scaler_scale_in_time_window - Amount of time autoscaling should look for deciding scaling in
    
    - Google Managed Certificate
      - google_managed_certificate_name - Name of the ssl certificate that will be created for your domain

    - External Load balancer for webapp
      - lb_load_balancing_scheme - Load balancing scheme of the load balancer
      
      - LB Backend Service
        - lb_backend_service_name: Name of the backend service for the load balancer
        - lb_backend_service_protocol: Protocol used by the backend service (e.g., HTTP)
        - lb_backend_session_affinity: Session affinity type for the backend service (e.g., NONE)
        - lb_backend_timeout_sec: Timeout duration for backend connections in seconds
        - lb_backend_connection_draining_timeout_sec: Timeout duration for draining connections from the backend service in seconds
        - lb_backend_locality_lb_policy: Locality-based load balancing policy for the backend service (e.g., ROUND_ROBIN)
        - lb_backend_balancing_mode: Load balancing mode for the backend service (e.g., UTILIZATION)
        - lb_backend_max_utilization: Maximum utilization threshold for the backend service
        - lb_backend_capacity_scaler: Capacity scaler for the backend service
        - lb_backend_log_enable: Flag to enable logging for the backend service
        - lb_backend_log_sample_rate: Sampling rate for logging requests to the backend service
      
      - LB Target Proxy
        - lb_target_proxy_name: Name of the target proxy for the load balancer
        - lb_target_proxy_http_keep_alive_timeout_sec: HTTP keep-alive timeout duration for the target proxy in seconds
      
      - LB URL Map
        - lb_url_map_name: Name of the URL map for the load balancer
        - lb_url_map_host: Host pattern for URL map routing
        - lb_url_map_path_matcher: Path matcher pattern for URL map routing

      - LB Forwarding Rule
        - lb_forwarding_rule_name: Name of the forwarding rule for the load balancer
        - lb_forwarding_rule_ip_protocol: IP protocol used by the forwarding rule (e.g., TCP)
        - lb_forwarding_rule_ip_version: IP version used by the forwarding rule (e.g., IPV4)
        - lb_forwarding_rule_port_range: Port range for the forwarding rule (e.g., 443)

## Instructions
1. Initialize terraform using ```terraform init```
2. Check the changes the template will apply using ```terraform plan -var-file=<YOUR_TFVARS_FILE>```
3. Apply the changes using ```terraform apply -var-file=<YOUR_TFVARS_FILE>```
