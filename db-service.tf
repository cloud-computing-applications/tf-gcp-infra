resource "google_compute_global_address" "db_ps_ip_range" {
  depends_on = [
    google_compute_network.vpc,
    google_compute_subnetwork.webapp-subnet,
    google_compute_subnetwork.db-subnet,
    google_compute_route.webapp-route,
    google_compute_firewall.deny-all-firewall,
    google_compute_firewall.webapp-http-firewall
  ]
  provider      = google-beta
  project       = google_compute_network.vpc.project
  name          = var.db_ps_ip_range_address_name
  address_type  = var.db_ps_ip_range_address_type
  purpose       = var.db_ps_ip_range_address_purpose
  network       = google_compute_network.vpc.id
  address       = var.db_ps_ip_range_address_first_ip
  prefix_length = var.db_ps_ip_range_address_prefix_length
}

resource "google_service_networking_connection" "db_ps_connection" {
  depends_on = [
    google_compute_network.vpc,
    google_compute_subnetwork.webapp-subnet,
    google_compute_subnetwork.db-subnet,
    google_compute_route.webapp-route,
    google_compute_firewall.deny-all-firewall,
    google_compute_firewall.webapp-http-firewall,
    google_compute_global_address.db_ps_ip_range
  ]
  provider                = google-beta
  network                 = google_compute_network.vpc.id
  service                 = var.db_ps_connection_service
  reserved_peering_ranges = [google_compute_global_address.db_ps_ip_range.name]
  deletion_policy         = var.db_ps_connection_deletion_policy
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "db_instance" {
  depends_on = [
    google_compute_network.vpc,
    google_compute_subnetwork.webapp-subnet,
    google_compute_subnetwork.db-subnet,
    google_compute_route.webapp-route,
    google_compute_firewall.deny-all-firewall,
    google_compute_firewall.webapp-http-firewall,
    google_compute_global_address.db_ps_ip_range,
    google_service_networking_connection.db_ps_connection
  ]
  name                = "${var.db_instance_name}-${random_id.db_name_suffix.hex}"
  database_version    = var.db_instance_database_version
  region              = var.db_instance_region
  deletion_protection = var.db_instance_deletion_protection

  settings {
    tier              = var.db_instance_tier
    availability_type = var.db_instance_availability_type
    edition           = var.db_instance_edition
    disk_type         = var.db_instance_disk_type
    disk_size         = var.db_instance_disk_size
    ip_configuration {
      ipv4_enabled                                  = var.db_instance_ipv4_enabled
      private_network                               = google_compute_network.vpc.id
      allocated_ip_range                            = google_compute_global_address.db_ps_ip_range.name
      enable_private_path_for_google_cloud_services = var.db_instance_enable_private_path_for_google_cloud_services
    }

    backup_configuration {
      enabled            = var.db_instance_backup_configuration_enabled
      binary_log_enabled = var.db_instance_binary_log_enabled
    }
  }
}

resource "random_password" "db_password" {
  depends_on = [
    google_sql_database_instance.db_instance
  ]
  length           = var.db_password_length
  special          = var.db_password_special
  override_special = var.db_password_override_special
}

resource "google_sql_user" "db_user" {
  depends_on = [
    google_sql_database_instance.db_instance,
    random_password.db_password
  ]

  name     = var.db_user_name
  instance = google_sql_database_instance.db_instance.name
  password = random_password.db_password.result
}

resource "google_sql_database" "database" {
  depends_on = [
    google_sql_database_instance.db_instance,
    google_sql_user.db_user
  ]
  name     = var.database_name
  instance = google_sql_database_instance.db_instance.name
}

resource "google_compute_firewall" "deny-db-firewall" {
  depends_on = [
    google_compute_global_address.db_ps_ip_range,
    google_sql_database_instance.db_instance
  ]
  name               = var.deny_all_db_firewall_name
  network            = google_compute_network.vpc.id
  direction          = var.deny_all_db_firewall_direction
  source_ranges      = [var.deny_all_db_firewall_source_range]
  destination_ranges = ["${google_compute_global_address.db_ps_ip_range.address}/${google_compute_global_address.db_ps_ip_range.prefix_length}"]
  priority           = var.deny_all_db_firewall_priority
  deny {
    protocol = var.deny_all_db_firewall_protocol
  }
}

resource "google_compute_firewall" "allow-db-firewall" {
  depends_on = [
    google_compute_global_address.db_ps_ip_range,
    google_sql_database_instance.db_instance
  ]
  name               = var.allow_db_firewall_name
  network            = google_compute_network.vpc.id
  direction          = var.allow_db_firewall_direction
  target_tags        = [var.allow_db_http_tag]
  destination_ranges = ["${google_compute_global_address.db_ps_ip_range.address}/${google_compute_global_address.db_ps_ip_range.prefix_length}"]
  priority           = var.allow_db_firewall_priority
  allow {
    protocol = var.allow_db_firewall_protocol
    ports    = [var.allow_db_tcp_port]
  }
}