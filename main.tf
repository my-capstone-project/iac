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