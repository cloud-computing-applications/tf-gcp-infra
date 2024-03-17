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
  type = list(string)
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

variable "dns_zone_name" {
  type = string
}

variable "webapp-a-rs-type" {
  type = string
}

variable "webapp-a-rs-ttl" {
  type = number
}

variable "webapp-service-account-name" {
  type = string
}

variable "webapp-service-account-description" {
  type = string
}

variable "webapp-service-account-permissions" {
  type = list(string)
}