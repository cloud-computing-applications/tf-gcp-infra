data "template_file" "startup" {
  depends_on = [
    google_sql_database_instance.db_instance,
    google_sql_user.db_user,
    google_sql_database.database
  ]

  template = file(var.webapp_startup_script_path)
  vars = {
    PORT          = var.application_port
    DB_USERNAME   = google_sql_user.db_user.name
    DB_PASSWORD   = google_sql_user.db_user.password
    DB_DATABASE   = google_sql_database.database.name
    DB_HOST       = google_sql_database_instance.db_instance.private_ip_address
    ENVIRONMENT   = var.environment
    LOG_FILE_PATH = var.log_file_path
    TOPIC_NAME    = var.topic_name
    EXPIRY_BUFFER = var.EXPIRY_BUFFER
  }
}

resource "google_service_account" "webapp-service-account" {
  account_id   = var.webapp_service_account_name
  display_name = var.webapp_service_account_name
  description  = var.webapp_service_account_description
}

locals {
  webapp_service_account_permissions_array        = split(",", var.webapp_service_account_permissions)
  webapp_service_account_scopes_array             = split(",", var.webapp_service_account_scopes)
  webapp_instance_group_distribution_policy_zones = split(",", var.webapp_igm_distribution_policy_zones)
}

resource "google_project_iam_binding" "webapp-service-account-permissions" {
  depends_on = [
    google_service_account.webapp-service-account,
    local.webapp_service_account_permissions_array
  ]

  for_each = toset(local.webapp_service_account_permissions_array)

  project = var.project_id
  role    = each.value

  members = [
    google_service_account.webapp-service-account.member
  ]
}

resource "google_compute_firewall" "webapp-allow-hc" {
  name = var.webapp_allow_hc_firewall_name
  allow {
    protocol = var.webapp_allow_hc_protocol
    ports    = [var.application_port]
  }
  direction          = var.webapp_allow_hc_firewall_direction
  network            = google_compute_network.vpc.id
  priority           = var.webapp_allow_hc_priority
  source_ranges      = [var.webapp_allow_hc_source_range_1, var.webapp_allow_hc_source_range_2]
  destination_ranges = [var.webapp_subnet_cidr]
  target_tags        = [var.webapp_allow_hc_tag]
}

resource "google_compute_region_instance_template" "webapp-instance-template" {
  depends_on = [
    google_compute_network.vpc,
    google_compute_subnetwork.webapp-subnet,
    google_compute_subnetwork.db-subnet,
    google_compute_route.webapp-route,
    google_compute_firewall.deny-all-firewall,
    google_compute_firewall.webapp-allow-hc,
    google_sql_database_instance.db_instance,
    google_sql_user.db_user,
    google_sql_database.database,
    google_compute_firewall.deny-db-firewall,
    google_compute_firewall.allow-db-firewall,
    data.template_file.startup,
    google_service_account.webapp-service-account,
    google_project_iam_binding.webapp-service-account-permissions,
    local.webapp_service_account_scopes_array,
    google_kms_crypto_key_iam_binding.vm_crypto_key_binding
  ]

  name           = var.webpp_instance_template_name
  machine_type   = var.webapp_instance_template_machine_type
  region         = var.webapp_subnet_region
  can_ip_forward = var.webapp_instance_template_can_ip_forward
  tags           = [var.webapp_allow_hc_tag, var.allow_db_http_tag]

  scheduling {
    provisioning_model  = var.webapp_instance_template_provisioning_model
    automatic_restart   = var.webapp_instance_template_automatic_restart
    on_host_maintenance = var.webapp_instance_template_on_host_maintenance
  }

  disk {
    boot         = var.webapp_instance_template_is_boot_disk
    source_image = "projects/${var.project_id}/global/images/${var.webapp_image_name}"
    auto_delete  = var.webapp_instance_template_auto_delete_disk
    disk_type    = var.webapp_instance_template_disk_type
    disk_size_gb = var.webapp_instance_template_disk_size
    disk_encryption_key {
      kms_key_self_link = local.vm_key_id
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.webapp-subnet.name
    access_config {}
  }

  metadata_startup_script = data.template_file.startup.rendered

  service_account {
    email  = google_service_account.webapp-service-account.email
    scopes = local.webapp_service_account_scopes_array
  }
}

resource "google_compute_health_check" "webapp-health-check-igm" {
  name                = var.webapp_health_check_igm_name
  check_interval_sec  = var.webapp_health_check_igm_interval
  timeout_sec         = var.webapp_health_check_igm_timeout
  healthy_threshold   = var.webapp_health_check_igm_healthy_threshold
  unhealthy_threshold = var.webapp_health_check_igm_unhealthy_threshold

  http_health_check {
    request_path = var.webapp_health_check_igm_request_path
    port         = var.application_port
  }
}

resource "google_compute_region_instance_group_manager" "webapp-instance-manager" {
  depends_on = [
    google_compute_region_instance_template.webapp-instance-template,
    google_compute_health_check.webapp-health-check-igm
  ]
  name                             = var.webapp_igm_name
  base_instance_name               = var.webapp_igm_base_instance_name
  provider                         = google-beta
  region                           = var.webapp_subnet_region
  distribution_policy_zones        = local.webapp_instance_group_distribution_policy_zones
  distribution_policy_target_shape = var.webapp_igm_distribution_policy_target_shape

  update_policy {
    type                         = var.webapp_igm_update_policy_type
    instance_redistribution_type = var.webapp_igm_instance_redistribution_type
    minimal_action               = var.webapp_igm_update_policy_minimal_action
    max_surge_fixed              = length(local.webapp_instance_group_distribution_policy_zones)
  }

  instance_lifecycle_policy {
    force_update_on_repair    = var.webapp_igm_force_update_on_repair
    default_action_on_failure = var.webapp_igm_default_action_on_failure
  }

  named_port {
    name = var.webapp_igm_named_port_name
    port = var.application_port
  }

  version {
    instance_template = google_compute_region_instance_template.webapp-instance-template.id
    name              = var.webapp_igm_name
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.webapp-health-check-igm.id
    initial_delay_sec = var.webapp_igm_hc_inital_delay
  }
}

resource "google_compute_region_autoscaler" "webapp-auto-scaler" {
  depends_on = [google_compute_region_instance_group_manager.webapp-instance-manager]

  name     = var.webapp_auto_scaler_name
  region   = var.webapp_subnet_region
  provider = google-beta
  target   = google_compute_region_instance_group_manager.webapp-instance-manager.id

  autoscaling_policy {
    max_replicas    = var.webapp_auto_scaler_max_replicas
    min_replicas    = var.webapp_auto_scaler_min_replicas
    cooldown_period = var.webapp_auto_scaler_cooldown_period
    mode            = var.webapp_auto_scaler_mode

    cpu_utilization {
      target            = var.webapp_auto_scaler_cpu_target
      predictive_method = var.webapp_auto_scaler_predictive_method
    }

    scale_in_control {
      max_scaled_in_replicas {
        fixed = var.webapp_auto_scaler_max_replicas - 1
      }
      time_window_sec = var.webapp_auto_scaler_scale_in_time_window
    }
  }
}