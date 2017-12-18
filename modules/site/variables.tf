variable "domain" {}

variable "ip_addresses" {
	type = "list"
}

variable "region" {
	default = "us-central1"
}

variable "prod_subdomain" {
	default = "www"
}

variable "testing_subdomain" {
	default = "new"
}

variable "main_page_suffix" {
	default = "index.html"
}

variable "not_found_page" {
	default = "404.html"
}
