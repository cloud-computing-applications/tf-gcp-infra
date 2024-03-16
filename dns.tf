data "google_dns_managed_zone" "webapp-dns" {
  depends_on = [
    google_compute_instance.webapp-instance
  ]
  name = var.dns_zone_name
}

resource "google_dns_record_set" "webapp-a-rs" {
  depends_on = [
    google_compute_instance.webapp-instance,
    data.google_dns_managed_zone.webapp-dns
  ]
  managed_zone = data.google_dns_managed_zone.webapp-dns.name
  name         = data.google_dns_managed_zone.webapp-dns.dns_name
  type         = var.webapp-a-rs-type
  ttl          = var.webapp-a-rs-ttl
  rrdatas      = [google_compute_instance.webapp-instance.network_interface.0.access_config.0.nat_ip]
}