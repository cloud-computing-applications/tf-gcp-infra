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

variable "webapp_allow_http_firewall_name" {
  type = string
}

variable "webapp_http_port" {
  type = string
}

variable "webapp_allow_http_tag" {
  type = string
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
