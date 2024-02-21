variable "project_id" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_routing_mode" {
  type = string
}

variable "webapp_subnet_name" {
  type = string
}

variable "webapp_subnet_cidr" {
  type = string
}

variable "webapp_subnet_region" {
  type = string
}

variable "deny_all_firewall_name" {
  type = string
}

variable "deny_all_firewall_direction" {
  type = string
}

variable "deny_all_firewall_source_range" {
  type = string
}

variable "deny_all_firewall_destination_range" {
  type = string
}

variable "deny_all_firewall_protocol" {
  type = string
}

variable "deny_all_firewall_priority" {
  type = number
}


variable "webapp_allow_http_firewall_name" {
  type = string
}

variable "webapp_allow_http_firewall_direction" {
  type = string
}

variable "webapp_allow_http_source_range" {
  type = string
}

variable "webapp_allow_http_protocol" {
  type = string
}

variable "webapp_tcp_port" {
  type = string
}

variable "webapp_allow_http_tag" {
  type = string
}

variable "webapp_allow_http_priority" {
  type = number
}

variable "webpp_instance_name" {
  type = string
}

variable "webapp_machine_type" {
  type = string
}

variable "webapp_instance_zone" {
  type = string
}

variable "webapp_instance_disk_size" {
  type = number
}

variable "webapp_instance_disk_type" {
  type = string
}

variable "webapp_image_family" {
  type = string
}

variable "db_subnet_name" {
  type = string
}

variable "db_subnet_cidr" {
  type = string
}

variable "db_subnet_region" {
  type = string
}

variable "webapp_default_route_name" {
  type = string
}

variable "webapp_default_route_dest_range" {
  type = string
}

variable "webapp_default_route_next_hop_gateway" {
  type = string
}
