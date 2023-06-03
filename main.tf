terraform {
  backend "gcs" {
    bucket = "terraform-capstone-repoth"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = "${var.project_id}"
  credentials = file("credential.json")
}

# Create new storage bucket in the US multi-region
# with standard storage
resource "google_storage_bucket" "static" {
 name          = "terraform-${var.project_id}"
 location      = "ASIA"
 storage_class = "STANDARD"

 uniform_bucket_level_access = true
 versioning {
   enabled = true
 }
}

resource "google_compute_instance" "default" {
  name         = "testing"
  machine_type = "n1-standard-2"
  zone         = "asia-southeast2-a"

  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

}