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

variable "EXPIRY_BUFFER" {
  type      = number
  sensitive = true
}

variable "webapp_allow_hc_firewall_name" {
  type = string
}

variable "webapp_allow_hc_source_range_1" {
  type = string
}

variable "webapp_allow_hc_source_range_2" {
  type = string
}

variable "webapp_allow_hc_protocol" {
  type = string
}

variable "webapp_allow_hc_firewall_direction" {
  type = string
}

variable "webapp_allow_hc_tag" {
  type = string
}

variable "webapp_allow_hc_priority" {
  type = number
}

variable "webpp_instance_template_name" {
  type = string
}

variable "webapp_instance_template_machine_type" {
  type = string
}

variable "webapp_instance_template_is_boot_disk" {
  type = bool
}

variable "webapp_instance_template_auto_delete_disk" {
  type = bool
}

variable "webapp_instance_template_disk_size" {
  type = number
}

variable "webapp_instance_template_disk_type" {
  type = string
}

variable "webapp_instance_template_can_ip_forward" {
  type = bool
}

variable "webapp_instance_template_provisioning_model" {
  type = string
}

variable "webapp_instance_template_automatic_restart" {
  type = bool
}

variable "webapp_instance_template_on_host_maintenance" {
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

variable "webapp_health_check_igm_name" {
  type = string
}

variable "webapp_health_check_igm_interval" {
  type = number
}

variable "webapp_health_check_igm_timeout" {
  type = number
}

variable "webapp_health_check_igm_healthy_threshold" {
  type = number
}

variable "webapp_health_check_igm_unhealthy_threshold" {
  type = number
}

variable "webapp_health_check_igm_request_path" {
  type = string
}

variable "webapp_health_check_lb_name" {
  type = string
}

variable "webapp_health_check_lb_interval" {
  type = number
}

variable "webapp_health_check_lb_timeout" {
  type = number
}

variable "webapp_health_check_lb_healthy_threshold" {
  type = number
}

variable "webapp_health_check_lb_unhealthy_threshold" {
  type = number
}

variable "webapp_health_check_lb_request_path" {
  type = string
}

variable "webapp_igm_name" {
  type = string
}

variable "webapp_igm_base_instance_name" {
  type = string
}

variable "webapp_igm_distribution_policy_zones" {
  type = string
}

variable "webapp_igm_distribution_policy_target_shape" {
  type = string
}

variable "webapp_igm_update_policy_type" {
  type = string
}

variable "webapp_igm_instance_redistribution_type" {
  type = string
}

variable "webapp_igm_update_policy_minimal_action" {
  type = string
}

variable "webapp_igm_force_update_on_repair" {
  type = string
}

variable "webapp_igm_default_action_on_failure" {
  type = string
}

variable "webapp_igm_named_port_name" {
  type = string
}

variable "webapp_igm_hc_inital_delay" {
  type = number
}

variable "webapp_auto_scaler_name" {
  type = string
}

variable "webapp_auto_scaler_max_replicas" {
  type = number
}

variable "webapp_auto_scaler_min_replicas" {
  type = number
}

variable "webapp_auto_scaler_cooldown_period" {
  type = number
}

variable "webapp_auto_scaler_mode" {
  type = string
}

variable "webapp_auto_scaler_cpu_target" {
  type = number
}

variable "webapp_auto_scaler_predictive_method" {
  type = string
}

variable "webapp_auto_scaler_scale_in_time_window" {
  type = number
}

variable "google_managed_certificate_name" {
  type = string
}

variable "lb_load_balancing_scheme" {
  type = string
}

variable "lb_backend_service_name" {
  type = string
}

variable "lb_backend_service_protocol" {
  type = string
}

variable "lb_backend_session_affinity" {
  type = string
}

variable "lb_backend_timeout_sec" {
  type = number
}

variable "lb_backend_connection_draining_timeout_sec" {
  type = number
}

variable "lb_backend_locality_lb_policy" {
  type = string
}

variable "lb_backend_balancing_mode" {
  type = string
}

variable "lb_backend_max_utilization" {
  type = number
}

variable "lb_backend_capacity_scaler" {
  type = number
}

variable "lb_backend_log_enable" {
  type = bool
}

variable "lb_backend_log_sample_rate" {
  type = number
}

variable "lb_target_proxy_name" {
  type = string
}

variable "lb_target_proxy_http_keep_alive_timeout_sec" {
  type = number
}

variable "lb_url_map_name" {
  type = string
}

variable "lb_url_map_host" {
  type = string
}

variable "lb_url_map_path_matcher" {
  type = string
}

variable "lb_forwarding_rule_name" {
  type = string
}

variable "lb_forwarding_rule_ip_protocol" {
  type = string
}

variable "lb_forwarding_rule_ip_version" {
  type = string
}

variable "lb_forwarding_rule_port_range" {
  type = string
}