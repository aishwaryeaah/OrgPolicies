terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.16.0"
    }
  }
}

provider "google" {
  user_project_override = true
  billing_project       = "aishwarya-orgpolicy-test"
}
