terraform {
	backend "gcs" {
		bucket  = "danielhess-me-infra"
		prefix  = "terraform/testing"
		project = "danielhess-me"
	}
}

provider "google" {
	project     = "${var.project}"
	region      = "${var.region}"
}
