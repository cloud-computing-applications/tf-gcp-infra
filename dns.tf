data "google_dns_managed_zone" "webapp-dns" {
  name = var.dns_zone_name
}

resource "google_dns_record_set" "webapp-a-rs" {
  depends_on = [
    google_compute_global_forwarding_rule.lb-forwarding-rule,
    data.google_dns_managed_zone.webapp-dns
  ]
  managed_zone = data.google_dns_managed_zone.webapp-dns.name
  name         = data.google_dns_managed_zone.webapp-dns.dns_name
  type         = var.webapp_a_rs_type
  ttl          = var.webapp_a_rs_ttl
  rrdatas      = [google_compute_global_forwarding_rule.lb-forwarding-rule.ip_address]
}