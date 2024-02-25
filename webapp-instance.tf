data "template_file" "startup" {
  depends_on = [
    google_sql_database_instance.db_instance,
    google_sql_user.db_user,
    google_sql_database.database
  ]

  template = file(var.webapp_startup_script_path)
  vars = {
    PORT        = var.application_port
    DB_USERNAME = google_sql_user.db_user.name
    DB_PASSWORD = google_sql_user.db_user.password
    DB_DATABASE = google_sql_database.database.name
    DB_HOST     = google_sql_database_instance.db_instance.private_ip_address
  }
}

resource "google_compute_instance" "webapp-instance" {
  depends_on = [
    google_compute_network.vpc,
    google_compute_subnetwork.webapp-subnet,
    google_compute_subnetwork.db-subnet,
    google_compute_route.webapp-route,
    google_compute_firewall.deny-all-firewall,
    google_compute_firewall.webapp-http-firewall,
    google_sql_database_instance.db_instance,
    google_sql_user.db_user,
    google_sql_database.database,
    google_compute_firewall.deny-db-firewall,
    google_compute_firewall.allow-db-firewall,
    data.template_file.startup
  ]

  name         = var.webpp_instance_name
  machine_type = var.webapp_machine_type
  zone         = var.webapp_instance_zone
  tags         = [var.webapp_allow_http_tag, var.allow_db_http_tag]

  boot_disk {
    auto_delete = true
    initialize_params {
      size  = var.webapp_instance_disk_size
      type  = var.webapp_instance_disk_type
      image = "projects/${var.project_id}/global/images/family/${var.webapp_image_family}"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.webapp-subnet.name
    access_config {}
  }

  metadata_startup_script = data.template_file.startup.rendered
}