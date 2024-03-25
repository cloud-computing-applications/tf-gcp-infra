resource "google_pubsub_schema" "verify_email_schema" {
  name       = var.topic_schema_name
  type       = var.topic_schema_type
  definition = file("${var.topic_schema_definition}")
}

resource "google_pubsub_topic" "verify_email_topic" {
  depends_on                 = [google_pubsub_schema.verify_email_schema]
  name                       = var.topic_name
  message_retention_duration = var.topic_message_retention_duration
  schema_settings {
    schema   = "projects/${google_pubsub_schema.verify_email_schema.project}/schemas/${google_pubsub_schema.verify_email_schema.name}"
    encoding = var.topic_schema_encoding
  }
}

data "google_iam_policy" "webapp-service-account-binding" {
  depends_on = [google_service_account.webapp-service-account]
  binding {
    role = var.webapp_service_account_binding_role
    members = [
      google_service_account.webapp-service-account.member
    ]
  }
}

resource "google_pubsub_topic_iam_policy" "policy" {
  project     = google_pubsub_topic.verify_email_topic.project
  topic       = google_pubsub_topic.verify_email_topic.name
  policy_data = data.google_iam_policy.webapp-service-account-binding.policy_data
}

resource "google_service_account" "sub-service-account" {
  account_id   = var.subscription_service_account_id
  display_name = var.subscription_service_account_name
}

resource "google_service_account" "cloud-function-service-account" {
  account_id   = var.cloud_function_service_account_id
  display_name = var.cloud_function_service_account_name
}

resource "random_id" "bucket_prefix" {
  byte_length = var.bucket_name_prefix_random_byte_length
}

resource "google_storage_bucket" "serverless_bucket" {
  name                        = "${random_id.bucket_prefix.hex}-${var.bucket_name_postfix}"
  storage_class               = var.bucket_storage_class
  location                    = var.bucket_location
  uniform_bucket_level_access = var.bucket_uniform_level_access
  force_destroy               = var.bucket_force_destroy
}

data "archive_file" "serverless_archive" {
  type        = var.archive_file_type
  output_path = var.archive_file_output_path
  source_dir  = var.archive_file_source_dir
}

resource "google_storage_bucket_object" "serverless" {
  name   = var.bucket_object_name
  bucket = google_storage_bucket.serverless_bucket.name
  source = data.archive_file.serverless_archive.output_path
}

resource "google_vpc_access_connector" "db-connector" {
  name          = var.db_vpc_connector_name
  ip_cidr_range = var.db_vpc_connector_ip_range
  network       = google_compute_network.vpc.id
  machine_type  = var.db_vpc_connector_machine_type
  min_instances = var.db_vpc_connector_min_instances
  max_instances = var.db_vpc_connector_max_instances
  region        = var.db_vpc_connector_region
}

resource "google_compute_firewall" "allow-db-access-cf" {
  depends_on         = [google_vpc_access_connector.db-connector]
  name               = var.allow_db_firewall_cf_name
  network            = google_compute_network.vpc.id
  direction          = var.allow_db_firewall_cf_direction
  source_ranges      = [google_vpc_access_connector.db-connector.ip_cidr_range]
  destination_ranges = ["${google_compute_global_address.db_ps_ip_range.address}/${google_compute_global_address.db_ps_ip_range.prefix_length}"]
  priority           = var.allow_db_firewall_cf_priority

  allow {
    protocol = var.allow_db_firewall_protocol
    ports    = [var.allow_db_tcp_port]
  }
}

resource "google_cloudfunctions2_function" "verify_email_function" {
  depends_on = [
    google_service_account.sub-service-account,
    google_service_account.cloud-function-service-account,
    google_pubsub_topic.verify_email_topic,
    google_storage_bucket_object.serverless,
    google_sql_database_instance.db_instance,
    google_sql_user.db_user,
    google_sql_database.database,
    google_vpc_access_connector.db-connector,
    google_compute_firewall.allow-db-access-cf
  ]

  name     = var.cloud_function_name
  location = var.cloud_function_location

  build_config {
    runtime     = var.cloud_function_runtime
    entry_point = var.cloud_function_entry_point
    source {
      storage_source {
        bucket = google_storage_bucket.serverless_bucket.name
        object = google_storage_bucket_object.serverless.name
      }
    }
  }

  service_config {
    timeout_seconds                = var.cloud_function_timeout_seconds
    available_memory               = var.cloud_function_memory
    available_cpu                  = var.cloud_function_cpu
    all_traffic_on_latest_revision = var.cloud_function_all_traffic_latest
    ingress_settings               = var.cloud_function_ingress_settings
    min_instance_count             = var.cloud_function_min_instances
    max_instance_count             = var.cloud_function_max_instances
    service_account_email          = google_service_account.cloud-function-service-account.email
    vpc_connector                  = google_vpc_access_connector.db-connector.id
    vpc_connector_egress_settings  = var.cloud_function_vpc_egress_settings
    environment_variables = {
      SEND_GRID_KEY         = var.SEND_GRID_KEY
      SEND_GRID_FROM        = var.SEND_GRID_FROM
      SEND_GRID_TEMPLATE_ID = var.SEND_GRID_TEMPLATE_ID
      DOMAIN_PROTOCOL       = var.DOMAIN_PROTOCOL
      DOMAIN_NAME           = var.DOMAIN_NAME
      WEBAPP_PORT           = var.WEBAPP_PORT
      DB_USERNAME           = google_sql_user.db_user.name
      DB_PASSWORD           = google_sql_user.db_user.password
      DB_DATABASE           = google_sql_database.database.name
      DB_HOST               = google_sql_database_instance.db_instance.private_ip_address
    }
  }

  event_trigger {
    trigger_region        = var.cloud_function_event_trigger_region
    event_type            = var.cloud_function_event_trigger_event_type
    pubsub_topic          = google_pubsub_topic.verify_email_topic.id
    retry_policy          = var.cloud_function_event_trigger_retry_policy
    service_account_email = google_service_account.sub-service-account.email
  }
}

data "google_iam_policy" "sub-service-account-binding" {
  depends_on = [google_service_account.sub-service-account]
  binding {
    role = var.subscription_service_account_binding_role
    members = [
      google_service_account.sub-service-account.member
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "policy" {
  depends_on  = [data.google_iam_policy.sub-service-account-binding]
  name        = google_cloudfunctions2_function.verify_email_function.name
  location    = google_cloudfunctions2_function.verify_email_function.location
  policy_data = data.google_iam_policy.sub-service-account-binding.policy_data
}