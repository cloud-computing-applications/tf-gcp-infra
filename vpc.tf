provider "google" {
  project = var.project_id
}

provider "google-beta" {
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
  dest_range       = var.webapp_default_route_dest_range
  network          = google_compute_subnetwork.webapp-subnet.network
  next_hop_gateway = var.webapp_default_route_next_hop_gateway
}

resource "google_compute_firewall" "deny-all-firewall" {
  name               = var.deny_all_firewall_name
  network            = google_compute_network.vpc.id
  direction          = var.deny_all_firewall_direction
  source_ranges      = [var.deny_all_firewall_source_range]
  destination_ranges = [var.deny_all_firewall_destination_range]
  priority           = var.deny_all_firewall_priority
  deny {
    protocol = var.deny_all_firewall_protocol
  }
}

resource "google_compute_firewall" "webapp-http-firewall" {
  name               = var.webapp_allow_http_firewall_name
  network            = google_compute_network.vpc.id
  direction          = var.webapp_allow_http_firewall_direction
  source_ranges      = [var.webapp_allow_http_source_range]
  destination_ranges = [var.webapp_subnet_cidr]
  target_tags        = [var.webapp_allow_http_tag]
  priority           = var.webapp_allow_http_priority
  allow {
    protocol = var.webapp_allow_http_protocol
    ports    = [var.webapp_tcp_port]
  }
}