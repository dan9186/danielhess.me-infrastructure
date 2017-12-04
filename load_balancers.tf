resource "google_compute_global_forwarding_rule" "site_forwarding_rule" {
	name       = "site-forwarding-rule"
	target     = "${google_compute_target_http_proxy.site_loadbalancer.self_link}"
	port_range = "80"
}

resource "google_compute_target_http_proxy" "site_loadbalancer" {
	name        = "site-loadbalancer"
	description = "Load Balancer for site"
	url_map     = "${google_compute_url_map.site_url_map.self_link}"

	lifecycle = {
		create_before_destroy = true
	}
}

resource "google_compute_url_map" "site_url_map" {
	name        = "site-url-map"
	description = "URL Map"

	default_service = "${google_compute_backend_bucket.prod_site_backend.self_link}"

	host_rule {
		hosts        = ["${var.prod_subdomain}.${var.domain}"]
		path_matcher = "prodpaths"
	}

	host_rule {
		hosts        = ["${var.testing_subdomain}.${var.domain}"]
		path_matcher = "testingpaths"
	}

	path_matcher {
		name            = "prodpaths"
		default_service = "${google_compute_backend_bucket.prod_site_backend.self_link}"

		path_rule {
			paths   = ["/*"]
			service = "${google_compute_backend_bucket.prod_site_backend.self_link}"
		}
	}

	path_matcher {
		name            = "testingpaths"
		default_service = "${google_compute_backend_bucket.testing_site_backend.self_link}"

		path_rule {
			paths   = ["/*"]
			service = "${google_compute_backend_bucket.testing_site_backend.self_link}"
		}
	}
}

resource "google_compute_backend_bucket" "prod_site_backend" {
	name        = "prod-site-backend-bucket"
	description = "Backend Bucket for prod site"
	bucket_name = "${google_storage_bucket.prod_site_bucket.name}"
	enable_cdn  = true
}

resource "google_compute_backend_bucket" "testing_site_backend" {
	name        = "testing-site-backend-bucket"
	description = "Backend Bucket for testing site"
	bucket_name = "${google_storage_bucket.testing_site_bucket.name}"
}
