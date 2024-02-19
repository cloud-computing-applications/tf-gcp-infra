resource "google_compute_instance" "webapp-instance" {
  depends_on = [
    google_compute_network.vpc,
    google_compute_subnetwork.webapp-subnet,
    google_compute_subnetwork.db-subnet,
    google_compute_route.webapp-route,
    google_compute_firewall.webapp-http-firewall
  ]

  name         = var.webpp_instance_name
  machine_type = var.webapp_machine_type
  zone         = var.webapp_instance_zone
  tags         = [var.webapp_allow_http_tag]

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
}