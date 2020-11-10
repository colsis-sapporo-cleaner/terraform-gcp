
provider "google" {
  credentials = file(var.credential)
  project     = var.project
  region      = var.region
}

module "lb" {
  source                = "./modules/http-load-balancer"
  name                  = var.name
  project               = var.project
  url_map               = var.www_count > 0 ? google_compute_url_map.urlmap-www[0].self_link: google_compute_url_map.urlmap-www-cms[0].self_link
  dns_managed_zone_name = var.dns_managed_zone_name
  custom_domain_names   = [var.custom_domain_name]
  create_dns_entries    = var.create_dns_entry
  dns_record_ttl        = var.dns_record_ttl
  enable_http           = var.enable_http
  enable_ssl            = var.enable_ssl
  ssl_certificates      = google_compute_managed_ssl_certificate.cert.*.self_link
  custom_labels         = var.custom_labels
}

module "instances" {
  source             = "./modules/instances"
  project            = var.project
  cms_delete_protect = var.cms_delete_protect
  cms_count          = var.cms_count
  cms_disk_size      = var.cms_disk_size
  cms_osimage        = var.cms_osimage
  cms_machine_type   = var.cms_machine_type
  www_delete_protect = var.www_delete_protect
  www_count          = var.www_count
  www_disk_size      = var.www_disk_size
  www_osimage        = var.www_osimage
  www_machine_type   = var.www_machine_type
  ssh_pub            = var.ssh_pub
  zone               = var.zone
}

module "firewall" {
  source  = "./modules/compute_firewall"
  project = var.project
  allow_ips = var.allow_ips
}

resource "google_compute_url_map" "urlmap-www" {
  count = var.www_count > 0 ? 1: 0
  project         = var.project
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.web[0].self_link
  host_rule {
    hosts        = ["*"]
    path_matcher = "all"
  }
  path_matcher {
    name            = "all"
    default_service = google_compute_backend_service.web[0].self_link
  }
}

resource "google_compute_url_map" "urlmap-www-cms" {
  count = var.www_count > 0 ? 0: 1
  project         = var.project
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.web-cms[0].self_link
  host_rule {
    hosts        = ["*"]
    path_matcher = "all"
  }
  path_matcher {
    name            = "all"
    default_service = google_compute_backend_service.web-cms[0].self_link
  }
}

resource "google_compute_backend_service" "web-cms" {
  count = var.www_count > 0 ? 0: 1
  project = var.project

  name        = "${var.name}-web-cms"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = true

  backend {
    group = google_compute_instance_group.web-cms[0].self_link
  }
  health_checks = [google_compute_health_check.http-health-check.self_link]

}

resource "google_compute_backend_service" "web" {
  count = var.www_count > 0 ? 1: 0
  project = var.project

  name        = "${var.name}-web"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = true

  backend {
    group = google_compute_instance_group.web[0].self_link
  }
  health_checks = [google_compute_health_check.http-health-check.self_link]
}

resource "google_compute_health_check" "http-health-check" {
  name                = "${var.project}-health-check"
  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port         = "80"
    request_path = "/healthcheck.html"
  }
}

resource "google_compute_managed_ssl_certificate" "cert" {
  provider = google-beta
  name     = "${var.project}-cert"
  count    = var.enable_ssl ? 1 : 0
  project  = var.project
  managed {
    domains = [var.domain]
  }
}

resource "google_compute_instance_group" "web-cms" {
  count = var.www_count > 0 ? 0: 1
  project = var.project
  name = "${var.name}-web-cms-instance-group"
  zone = var.zone
  instances = module.instances.prod-cms[*].self_link
  lifecycle {
    create_before_destroy = false
  }
  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_instance_group" "web" {
  count = var.www_count > 0 ? 1: 0
  project   = var.project
  name      = "${var.name}-instance-group"
  zone      = var.zone
  instances = module.instances.prod-web[*].self_link
  lifecycle {
    create_before_destroy = false
  }
  named_port {
    name = "http"
    port = 80
  }
}


