resource "google_storage_bucket" "prod_site_bucket" {
	name     = "${replace("${var.domain}", ".", "-")}-prod-site"
	location = "${var.region}"

	website {
		main_page_suffix = "index.html"
		not_found_page   = "index.html"
	}
}

resource "google_storage_bucket" "testing_site_bucket" {
	name     = "${replace("${var.domain}", ".", "-")}-testing-site"
	location = "${var.region}"

	website {
		main_page_suffix = "index.html"
		not_found_page   = "index.html"
	}
}

// TODO: Once the GCP provider supports IAM Roles for buckets, add steps to
// make the buckets public to read from
