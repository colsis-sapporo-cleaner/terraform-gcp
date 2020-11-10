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

variable "allow_ips" {
  type  = list(string)
  default = []
}
