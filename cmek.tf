data "google_project" "project" {
}

data "google_kms_key_ring" "keyring" {
  count    = var.key_ring_create ? 0 : 1
  name     = var.key_ring_name
  provider = google-beta
  location = var.webapp_subnet_region
}

resource "google_kms_key_ring" "keyring" {
  count    = var.key_ring_create ? 1 : 0
  name     = var.key_ring_name
  provider = google-beta
  location = var.webapp_subnet_region

  lifecycle {
    prevent_destroy = true
  }
}

data "google_kms_crypto_key" "vm_key" {
  count    = var.vm_key_create ? 0 : 1
  name     = var.vm_key_name
  provider = google-beta
  key_ring = local.key_ring_id
}

resource "google_kms_crypto_key" "vm_key" {
  count           = var.vm_key_create ? 1 : 0
  name            = var.vm_key_name
  provider        = google-beta
  key_ring        = local.key_ring_id
  rotation_period = var.key_rotation_period
  purpose         = var.key_purpose

  lifecycle {
    prevent_destroy = true
  }
}

data "google_kms_crypto_key" "sql_key" {
  count    = var.sql_key_create ? 0 : 1
  name     = var.sql_key_name
  key_ring = local.key_ring_id
  provider = google-beta
}

resource "google_kms_crypto_key" "sql_key" {
  count           = var.sql_key_create ? 1 : 0
  name            = var.sql_key_name
  key_ring        = local.key_ring_id
  provider        = google-beta
  rotation_period = var.key_rotation_period
  purpose         = var.key_purpose

  lifecycle {
    prevent_destroy = true
  }
}

data "google_kms_crypto_key" "bucket_key" {
  count    = var.bucket_key_create ? 0 : 1
  name     = var.bucket_key_name
  key_ring = local.key_ring_id
  provider = google-beta
}

resource "google_kms_crypto_key" "bucket_key" {
  count           = var.bucket_key_create ? 1 : 0
  name            = var.bucket_key_name
  key_ring        = local.key_ring_id
  provider        = google-beta
  rotation_period = var.key_rotation_period
  purpose         = var.key_purpose

  lifecycle {
    prevent_destroy = true
  }
}

locals {
  key_ring_id   = var.key_ring_create ? google_kms_key_ring.keyring[0].id : data.google_kms_key_ring.keyring[0].id
  vm_key_id     = var.vm_key_create ? google_kms_crypto_key.vm_key[0].id : data.google_kms_crypto_key.vm_key[0].id
  sql_key_id    = var.sql_key_create ? google_kms_crypto_key.sql_key[0].id : data.google_kms_crypto_key.sql_key[0].id
  bucket_key_id = var.bucket_key_create ? google_kms_crypto_key.bucket_key[0].id : data.google_kms_crypto_key.bucket_key[0].id
}

resource "google_kms_crypto_key_iam_binding" "vm_crypto_key_binding" {
  provider      = google-beta
  crypto_key_id = local.vm_key_id
  role          = var.key_binding_role

  members = [
    "serviceAccount:service-${data.google_project.project.number}@${var.compute_engine_service_agent_domain}",
  ]
}

resource "google_kms_crypto_key_iam_binding" "sql_crypto_key_binding" {
  provider      = google-beta
  crypto_key_id = local.sql_key_id
  role          = var.key_binding_role

  members = [
    "serviceAccount:service-${data.google_project.project.number}@${var.sql_service_agent_domain}",
  ]
}

resource "google_kms_crypto_key_iam_binding" "storage_crypto_key_binding" {
  provider      = google-beta
  crypto_key_id = local.bucket_key_id
  role          = var.key_binding_role

  members = [
    "serviceAccount:service-${data.google_project.project.number}@${var.storage_bucket_service_agent_domain}",
  ]
}