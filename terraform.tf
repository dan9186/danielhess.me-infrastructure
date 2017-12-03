terraform {
	backend "gcs" {
		bucket  = "danielhess-me"
		prefix  = "terraform/testing"
		project = "danielhess-me"
	}
}

provider "google" {
	credentials = "${var.creds}"
	project     = "${var.project}"
	region      = "${var.region}"
}
