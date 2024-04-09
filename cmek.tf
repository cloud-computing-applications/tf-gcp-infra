data "google_project" "project" {
}

resource "google_kms_key_ring" "keyring" {
  name     = "${var.key_ring_name_prefix}-${formatdate("YYYY-MM-DD't'hh-mm-ss'z'", timestamp())}"
  provider = google-beta
  location = var.webapp_subnet_region
}

resource "google_kms_crypto_key" "vm_key" {
  name            = var.vm_key_name
  provider        = google-beta
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = var.key_rotation_period
  purpose         = var.key_purpose
}

resource "google_kms_crypto_key" "sql_key" {
  name            = var.sql_key_name
  key_ring        = google_kms_key_ring.keyring.id
  provider        = google-beta
  rotation_period = var.key_rotation_period
  purpose         = var.key_purpose
}

resource "google_kms_crypto_key" "bucket_key" {
  name            = var.bucket_key_name
  key_ring        = google_kms_key_ring.keyring.id
  provider        = google-beta
  rotation_period = var.key_rotation_period
  purpose         = var.key_purpose
}

resource "google_kms_crypto_key_iam_binding" "vm_crypto_key_binding" {
  provider      = google-beta
  crypto_key_id = google_kms_crypto_key.vm_key.id
  role          = var.key_binding_role

  members = [
    "serviceAccount:service-${data.google_project.project.number}@${var.compute_engine_service_agent_domain}",
  ]
}

resource "google_kms_crypto_key_iam_binding" "sql_crypto_key_binding" {
  provider      = google-beta
  crypto_key_id = google_kms_crypto_key.sql_key.id
  role          = var.key_binding_role

  members = [
    "serviceAccount:service-${data.google_project.project.number}@${var.sql_service_agent_domain}",
  ]
}

resource "google_kms_crypto_key_iam_binding" "storage_crypto_key_binding" {
  provider      = google-beta
  crypto_key_id = google_kms_crypto_key.bucket_key.id
  role          = var.key_binding_role

  members = [
    "serviceAccount:service-${data.google_project.project.number}@${var.storage_bucket_service_agent_domain}",
  ]
}