resource "google_secret_manager_secret" "db_host" {
  secret_id = var.secret_db_host_name

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_host" {
  secret  = google_secret_manager_secret.db_host.id
  secret_data = google_sql_database_instance.db_instance.private_ip_address
}

resource "google_secret_manager_secret" "db_password" {
  secret_id = var.secret_db_password_name

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password" {
  secret  = google_secret_manager_secret.db_password.id
  secret_data = google_sql_user.db_user.password
}

resource "google_secret_manager_secret" "vm_kms_key" {
  secret_id = var.secret_vm_key_name

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "vm_kms_key" {
  secret  = google_secret_manager_secret.vm_kms_key.id
  secret_data = google_kms_crypto_key.vm_key.id
}