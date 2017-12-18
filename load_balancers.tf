resource "google_compute_target_http_proxy" "sites_loadbalancer" {
	name        = "sites-loadbalancer"
	description = "Load Balancer for sites"
	url_map     = "${google_compute_url_map.sites_url_map.self_link}"

	lifecycle = {
		create_before_destroy = true
	}
}

resource "google_compute_global_forwarding_rule" "sites_forwarding_rule" {
	name       = "sites-forwarding-rule"
	target     = "${google_compute_target_http_proxy.sites_loadbalancer.self_link}"
	port_range = "80"
}

resource "google_compute_url_map" "sites_url_map" {
	name        = "sites-url-map"
	description = "URL Map for Sites"

	default_service = "${module.danielhess-me.prod_backend}"


	// danielhess.me mappings
	host_rule {
		hosts        = ["${module.danielhess-me.prod_dns}"]
		path_matcher = "danielhess-me-prod-paths"
	}

	path_matcher {
		name            = "danielhess-me-prod-paths"
		default_service = "${module.danielhess-me.prod_backend}"

		path_rule {
			paths   = ["/*"]
			service = "${module.danielhess-me.prod_backend}"
		}
	}

	host_rule {
		hosts        = ["${module.danielhess-me.testing_dns}"]
		path_matcher = "danielhess-me-testing-paths"
	}

	path_matcher {
		name            = "danielhess-me-testing-paths"
		default_service = "${module.danielhess-me.testing_backend}"

		path_rule {
			paths   = ["/*"]
			service = "${module.danielhess-me.testing_backend}"
		}
	}
}
