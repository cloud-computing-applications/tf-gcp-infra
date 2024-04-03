resource "google_compute_managed_ssl_certificate" "webapp-ssl-cert" {
  name = var.google_managed_certificate_name

  managed {
    domains = [var.DOMAIN_NAME]
  }
}

resource "google_compute_health_check" "webapp-health-check-lb" {
  name                = var.webapp_health_check_lb_name
  check_interval_sec  = var.webapp_health_check_lb_interval
  timeout_sec         = var.webapp_health_check_lb_timeout
  healthy_threshold   = var.webapp_health_check_lb_healthy_threshold
  unhealthy_threshold = var.webapp_health_check_lb_unhealthy_threshold

  http_health_check {
    request_path = var.webapp_health_check_lb_request_path
    port         = var.application_port
  }
}

resource "google_compute_backend_service" "lb-backend" {
  depends_on = [
    google_compute_health_check.webapp-health-check-lb,
    google_compute_region_instance_group_manager.webapp-instance-manager
  ]
  name                            = var.lb_backend_service_name
  load_balancing_scheme           = var.lb_load_balancing_scheme
  health_checks                   = [google_compute_health_check.webapp-health-check-lb.id]
  protocol                        = var.lb_backend_service_protocol
  port_name                       = var.webapp_igm_named_port_name
  session_affinity                = var.lb_backend_session_affinity
  timeout_sec                     = var.lb_backend_timeout_sec
  connection_draining_timeout_sec = var.lb_backend_connection_draining_timeout_sec

  locality_lb_policy = var.lb_backend_locality_lb_policy

  backend {
    group           = google_compute_region_instance_group_manager.webapp-instance-manager.instance_group
    balancing_mode  = var.lb_backend_balancing_mode
    max_utilization = var.lb_backend_max_utilization
    capacity_scaler = var.lb_backend_capacity_scaler
  }

  log_config {
    enable      = var.lb_backend_log_enable
    sample_rate = var.lb_backend_log_sample_rate
  }
}

resource "google_compute_target_https_proxy" "lb-target-proxy" {
  name                        = var.lb_target_proxy_name
  url_map                     = google_compute_url_map.lb-url-map.id
  ssl_certificates            = [google_compute_managed_ssl_certificate.webapp-ssl-cert.id]
  http_keep_alive_timeout_sec = var.lb_target_proxy_http_keep_alive_timeout_sec
}

resource "google_compute_url_map" "lb-url-map" {
  name            = var.lb_url_map_name
  default_service = google_compute_backend_service.lb-backend.id

  host_rule {
    hosts        = [var.lb_url_map_host]
    path_matcher = var.lb_url_map_path_matcher
  }

  path_matcher {
    name            = var.lb_url_map_path_matcher
    default_service = google_compute_backend_service.lb-backend.id
  }
}

resource "google_compute_global_forwarding_rule" "lb-forwarding-rule" {
  name                  = var.lb_forwarding_rule_name
  provider              = google-beta
  ip_protocol           = var.lb_forwarding_rule_ip_protocol
  ip_version            = var.lb_forwarding_rule_ip_version
  load_balancing_scheme = var.lb_load_balancing_scheme
  port_range            = var.lb_forwarding_rule_port_range
  target                = google_compute_target_https_proxy.lb-target-proxy.id
}