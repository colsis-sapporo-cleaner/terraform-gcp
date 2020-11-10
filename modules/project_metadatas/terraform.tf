resource "google_compute_project_metadata_item" "ssh-keys" {
  project = var.project
  key     = "ssh-keys"
  value   = var.ssh_pub
}
