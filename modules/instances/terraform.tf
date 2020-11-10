module "project_metadata" {
  source  = "../project_metadatas"
  project = var.project
  ssh_pub = var.ssh_pub
}

resource "google_compute_instance" "prod-cms" {
  count               = var.cms_count
  name                = "prod-cms-${count.index + 1}"
  project             = var.project
  machine_type        = var.cms_machine_type
  zone                = var.zone
  tags                = ["http-server", "https-server"]
  deletion_protection = var.cms_delete_protect
  network_interface {
    network = "default"
    access_config {
    }
  }
  boot_disk {
    initialize_params {
      size  = var.cms_disk_size
      type  = "pd-ssd"
      image = var.cms_osimage
    }
    auto_delete = "true"
  }
}

output "prod-cms" {
  value = google_compute_instance.prod-cms
}

resource "google_compute_instance" "prod-web" {
  count               = var.www_count
  name                = "prod-web-${count.index + 1}"
  project             = var.project
  machine_type        = var.www_machine_type
  zone                = var.zone
  tags                = ["http-server", "https-server"]
  deletion_protection = var.www_delete_protect
  network_interface {
    network = "default"
  }
  boot_disk {
    initialize_params {
      size  = var.www_disk_size
      type  = "pd-ssd"
      image = var.www_osimage
    }
    auto_delete = "true"
  }
}

output "prod-web" {
  value = google_compute_instance.prod-web
}
