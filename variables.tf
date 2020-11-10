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

variable "zone" {
  type    = string
  default = ""
}

variable "name" {
  type    = string
  default = ""
}

variable "ssh_pub" {
  type    = string
  default = ""
}

variable "cms_count" {
  type    = string
  default = "1"
}

variable "www_count" {
  type    = string
  default = "1"
}

variable "cms_delete_protect" {
  type    = bool
  default = false
}

variable "cms_machine_type" {
  type    = string
  default = "custom-2-4096"
}

variable "cms_osimage" {
  type    = string
  default = "centos-cloud/centos-8"
}

variable "cms_disk_size" {
  type    = string
  default = "100"
}

variable "www_delete_protect" {
  type    = bool
  default = false
}

variable "www_machine_type" {
  type    = string
  default = "custom-2-4096"
}

variable "www_osimage" {
  type    = string
  default = "centos-cloud/centos-8"
}

variable "www_disk_size" {
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

variable "domain" {
  type    = string
  default = ""
}

variable "allow_ips" {
  type = list(string)
  default = []
}
