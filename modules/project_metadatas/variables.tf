variable "project" {
  type    = string
  default = ""
}

variable "credential" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "asia-northeast-1"
}

variable "name" {
  type    = string
  default = ""
}

variable "ssh_pub" {
  type    = string
  default = ""
}

variable "machine_type" {
  type    = string
  default = "custom-2-4096"
}

variable "osimage" {
  type    = string
  default = "centos-cloud/centos-8"
}

variable "disk_size" {
  type    = string
  default = "100"
}

variable "enable_ssl" {
  type    = bool
  default = true
}

variable "enable_http" {
  type    = bool
  default = true
}

variable "create_dns_entry" {
  type    = bool
  default = false
}

variable "custom_domain_name" {
  type    = string
  default = ""
}

variable "dns_managed_zone_name" {
  type    = string
  default = ""
}

variable "dns_record_ttl" {
  type    = string
  default = 60
}

variable "custom_labels" {
  type    = map(string)
  default = {}
}

