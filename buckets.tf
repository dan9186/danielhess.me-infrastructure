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

resource "google_storage_bucket_iam_member" "prod_site_iam_member" {
	bucket = "${google_storage_bucket.prod_site_bucket.name}"
	role   = "roles/storage.objectViewer"
	member = "allUsers"
}

resource "google_storage_bucket_iam_member" "testing_site_iam_member" {
	bucket = "${google_storage_bucket.testing_site_bucket.name}"
	role   = "roles/storage.objectViewer"
	member = "allUsers"
}
