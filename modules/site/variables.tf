variable "region" {
	default = "us-central1"
}

variable "domain" {}

variable "prod_subdomain" {
	default = "www"
}

variable "testing_subdomain" {
	default = "new"
}

variable "ip_addresses" {
	type = "list"
}
