module "danielhess-me" {
	source = "./modules/site"

	domain            = "danielhess.me"
	prod_subdomain    = "www"
	testing_subdomain = "new"
	region            = "${var.region}"
	ip_addresses      = ["${google_compute_global_forwarding_rule.sites_forwarding_rule.ip_address}"]
}
