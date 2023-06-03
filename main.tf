terraform {
  backend "gcs" {
    bucket = "terraform-capstone-repoth"
    prefix = "terraform/state"
  }
}

provider "google" {
  project     = "${var.project_id}"
  credentials = file("credential.json")
}

provider "google-beta" {
  project     = "${var.project_id}"
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

# VPC
resource "google_compute_network" "default" {
  name                    = "default"
  description             = "Default network for the project"
  auto_create_subnetworks = true
  mtu                     = 0
  routing_mode            = "REGIONAL"
}

resource "google_compute_network" "testing" {
  name                    = "testing"
  description             = "Testing network for the project"
  auto_create_subnetworks = true
  mtu                     = 1460
  routing_mode            = "REGIONAL"
}

// Firewall 
resource "google_compute_firewall" "default" {
  name    = "testing-firewall"
  network = google_compute_network.testing.name

  allow {
    protocol = "tcp"
    ports    = ["22", "8443"]
  }

  source_ranges = [ "0.0.0.0/0" ]
  target_tags   = [ "all" ]
}

# reserved IP address
resource "google_compute_address" "default" {
  name   = "public-ip"
  region = "asia-southeast2"
}

resource "google_compute_global_address" "default" {
  name         = "ipv4-address"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}

// VM
resource "google_compute_instance" "default" {
  name         = "testing"
  machine_type = "n1-standard-2"
  zone         = "asia-southeast2-a"

  tags = ["all"]

  boot_disk {
    auto_delete = false
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = google_compute_network.testing.self_link

    access_config {
      nat_ip = google_compute_address.default.address
      
    }
  }
}

output "public-ip" {
  description = "Public IP: "
  value       = google_compute_address.default.address
}