provider "google" {
  project = var.project_id
}

resource "google_compute_network" "vpc" {
  name                            = var.vpc_name
  routing_mode                    = var.vpc_routing_mode
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "webapp-subnet" {
  name                     = var.webapp_subnet_name
  ip_cidr_range            = var.webapp_subnet_cidr
  region                   = var.webapp_subnet_region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "db-subnet" {
  name                     = var.db_subnet_name
  ip_cidr_range            = var.db_subnet_cidr
  region                   = var.db_subnet_region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_route" "webapp-route" {
  name             = var.webapp_default_route_name
  dest_range       = "0.0.0.0/0"
  network          = google_compute_subnetwork.webapp-subnet.network
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_firewall" "webapp-http-firewall" {
  name               = var.webapp_allow_http_firewall_name
  network            = google_compute_network.vpc.id
  direction          = "INGRESS"
  source_ranges      = ["0.0.0.0/0"]
  destination_ranges = [var.webapp_subnet_cidr]
  target_tags        = [var.webapp_allow_http_tag]
  allow {
    protocol = "tcp"
    ports    = [var.webapp_http_port]
  }
}