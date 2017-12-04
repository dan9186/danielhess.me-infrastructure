variable "creds" {}

variable "project" {
	default = "danielhess-me"
}

variable "region" {
	default = "us-central1"
}

variable "zone" {
	default = "us-central1-c"
}

variable "domain" {
	default = "danielhess.me"
}

variable "prod_subdomain" {
	default = "www"
}

variable "testing_subdomain" {
	default = "new"
}
