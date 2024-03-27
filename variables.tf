variable "project_id" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_routing_mode" {
  type = string
}

variable "webapp_subnet_name" {
  type = string
}

variable "webapp_subnet_cidr" {
  type = string
}

variable "webapp_subnet_region" {
  type = string
}

variable "deny_all_firewall_name" {
  type = string
}

variable "deny_all_firewall_direction" {
  type = string
}

variable "deny_all_firewall_source_range" {
  type = string
}

variable "deny_all_firewall_destination_range" {
  type = string
}

variable "deny_all_firewall_protocol" {
  type = string
}

variable "deny_all_firewall_priority" {
  type = number
}


variable "webapp_allow_http_firewall_name" {
  type = string
}

variable "webapp_allow_http_firewall_direction" {
  type = string
}

variable "webapp_allow_http_source_range" {
  type = string
}

variable "webapp_allow_http_protocol" {
  type = string
}

variable "webapp_tcp_port" {
  type = string
}

variable "webapp_allow_http_tag" {
  type = string
}

variable "webapp_allow_http_priority" {
  type = number
}

variable "webpp_instance_name" {
  type = string
}

variable "webapp_machine_type" {
  type = string
}

variable "webapp_instance_zone" {
  type = string
}

variable "webapp_instance_disk_size" {
  type = number
}

variable "webapp_instance_disk_type" {
  type = string
}

variable "webapp_image_family" {
  type = string
}

variable "webapp_service_account_scopes" {
  type = string
}

variable "webapp_startup_script_path" {
  type = string
}

variable "db_subnet_name" {
  type = string
}

variable "db_subnet_cidr" {
  type = string
}

variable "db_subnet_region" {
  type = string
}

variable "webapp_default_route_name" {
  type = string
}

variable "webapp_default_route_dest_range" {
  type = string
}

variable "webapp_default_route_next_hop_gateway" {
  type = string
}

variable "db_ps_ip_range_address_name" {
  type = string
}

variable "db_ps_ip_range_address_type" {
  type = string
}

variable "db_ps_ip_range_address_purpose" {
  type = string
}

variable "db_ps_ip_range_address_first_ip" {
  type = string
}

variable "db_ps_ip_range_address_prefix_length" {
  type = number
}

variable "db_ps_connection_deletion_policy" {
  type = string
}

variable "db_ps_connection_service" {
  type = string
}

variable "db_instance_name" {
  type = string
}

variable "db_instance_database_version" {
  type = string
}

variable "db_instance_region" {
  type = string
}

variable "db_instance_deletion_protection" {
  type = bool
}

variable "db_instance_tier" {
  type = string
}

variable "db_instance_availability_type" {
  type = string
}

variable "db_instance_edition" {
  type = string
}

variable "db_instance_disk_type" {
  type = string
}

variable "db_instance_disk_size" {
  type = number
}

variable "db_instance_ipv4_enabled" {
  type = bool
}

variable "db_instance_enable_private_path_for_google_cloud_services" {
  type = bool
}

variable "db_instance_backup_configuration_enabled" {
  type = bool
}

variable "db_instance_binary_log_enabled" {
  type = bool
}

variable "db_password_length" {
  type = number
}

variable "db_password_special" {
  type = bool
}

variable "db_password_override_special" {
  type = string
}

variable "deny_all_db_firewall_name" {
  type = string
}

variable "deny_all_db_firewall_direction" {
  type = string
}

variable "deny_all_db_firewall_source_range" {
  type = string
}

variable "deny_all_db_firewall_priority" {
  type = number
}

variable "deny_all_db_firewall_protocol" {
  type = string
}

variable "allow_db_firewall_name" {
  type = string
}

variable "allow_db_firewall_direction" {
  type = string
}

variable "allow_db_http_tag" {
  type = string
}

variable "allow_db_firewall_priority" {
  type = number
}

variable "allow_db_firewall_protocol" {
  type = string
}

variable "allow_db_tcp_port" {
  type = string
}

variable "db_user_name" {
  type = string
}

variable "application_port" {
  type      = string
  sensitive = true
}

variable "database_name" {
  type      = string
  sensitive = true
}

variable "environment" {
  type = string
}

variable "log_file_path" {
  type      = string
  sensitive = true
}

variable "dns_zone_name" {
  type = string
}

variable "webapp_a_rs_type" {
  type = string
}

variable "webapp_a_rs_ttl" {
  type = number
}

variable "webapp_service_account_name" {
  type = string
}

variable "webapp_service_account_description" {
  type = string
}

variable "webapp_service_account_permissions" {
  type = string
}

variable "topic_schema_name" {
  type = string
}

variable "topic_schema_type" {
  type = string
}

variable "topic_schema_definition" {
  type = string
}

variable "topic_name" {
  type = string
}

variable "topic_message_retention_duration" {
  type = string
}

variable "topic_schema_encoding" {
  type = string
}

variable "subscription_service_account_id" {
  type = string
}

variable "subscription_service_account_name" {
  type = string
}

variable "cloud_function_service_account_id" {
  type = string
}

variable "cloud_function_service_account_name" {
  type = string
}

variable "bucket_name_prefix_random_byte_length" {
  type = number
}

variable "bucket_name_postfix" {
  type = string
}

variable "bucket_storage_class" {
  type = string
}

variable "bucket_location" {
  type = string
}

variable "bucket_uniform_level_access" {
  type = bool
}

variable "bucket_force_destroy" {
  type = bool
}

variable "archive_file_type" {
  type = string
}

variable "archive_file_output_path" {
  type = string
}

variable "archive_file_source_dir" {
  type = string
}

variable "bucket_object_name" {
  type = string
}

variable "db_vpc_connector_name" {
  type = string
}

variable "db_vpc_connector_ip_range" {
  type = string
}

variable "db_vpc_connector_machine_type" {
  type = string
}

variable "db_vpc_connector_min_instances" {
  type = number
}

variable "db_vpc_connector_max_instances" {
  type = number
}

variable "db_vpc_connector_region" {
  type = string
}

variable "allow_db_firewall_cf_name" {
  type = string
}

variable "allow_db_firewall_cf_direction" {
  type = string
}

variable "allow_db_firewall_cf_priority" {
  type = number
}

variable "cloud_function_name" {
  type = string
}

variable "cloud_function_location" {
  type = string
}

variable "cloud_function_runtime" {
  type = string
}

variable "cloud_function_entry_point" {
  type = string
}

variable "cloud_function_timeout_seconds" {
  type = number
}

variable "cloud_function_memory" {
  type = string
}

variable "cloud_function_cpu" {
  type = string
}

variable "cloud_function_all_traffic_latest" {
  type = bool
}

variable "cloud_function_ingress_settings" {
  type = string
}

variable "cloud_function_min_instances" {
  type = number
}

variable "cloud_function_max_instances" {
  type = number
}

variable "cloud_function_vpc_egress_settings" {
  type = string
}

variable "cloud_function_event_trigger_region" {
  type = string
}

variable "cloud_function_event_trigger_event_type" {
  type = string
}

variable "cloud_function_event_trigger_retry_policy" {
  type = string
}

variable "subscription_service_account_binding_role_for_cf" {
  type = string
}

variable "subscription_service_account_binding_role_for_topic" {
  type = string
}

variable "webapp_service_account_binding_role" {
  type = string
}

variable "SEND_GRID_KEY" {
  type      = string
  sensitive = true
}

variable "SEND_GRID_FROM" {
  type      = string
  sensitive = true
}

variable "SEND_GRID_TEMPLATE_ID" {
  type      = string
  sensitive = true
}

variable "DOMAIN_PROTOCOL" {
  type      = string
  sensitive = true
}

variable "DOMAIN_NAME" {
  type      = string
  sensitive = true
}

variable "WEBAPP_PORT" {
  type      = string
  sensitive = true
}

variable "EXPIRY_BUFFER" {
  type      = number
  sensitive = true
}