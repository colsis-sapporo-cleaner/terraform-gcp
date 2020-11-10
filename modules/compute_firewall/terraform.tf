resource "google_compute_firewall" "allow-from-ips" {
  allow {
    protocol = "all"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "allow-from-ips"
  network       = "default"
  priority      = "1"
  project       = var.project
  source_ranges = var.allow_ips
}

resource "google_compute_firewall" "allow-internal" {
  allow {
    protocol = "all"
  }
  direction = "INGRESS"
  disabled = "false"
  name = "allow-internal"
  network = "default"
  priority = "10"
  project = var.project
  source_ranges = []
}

resource "google_compute_firewall" "deny-ssh" {
  deny {
    protocol = "tcp"
    ports = ["22"]
  }
  direction = "INGRESS"
  disabled = "false"
  name = "deny-ssh"
  network = "default"
  priority = "1000"
  project = var.project
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "deny-rdp" {
  deny {
    protocol = "tcp"
    ports = ["3389"]
  }
  direction = "INGRESS"
  disabled = "false"
  name = "deny-rdp"
  network = "default"
  priority = "1000"
  project = var.project
  source_ranges = ["10.128.0.0/9"]
}

resource "google_compute_firewall" "allow-http" {
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "allow-http"
  network       = "default"
  priority      = "1000"
  project       = var.project
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow-https" {
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "allow-https"
  network       = "default"
  priority      = "1000"
  project       = var.project
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

