resource "google_storage_bucket" "prod_site_bucket" {
	name     = "${replace("${var.domain}", ".", "-")}-prod-site"
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

resource "google_compute_backend_bucket" "prod_backend" {
	name        = "${replace("${var.domain}", ".", "-")}-prod-backend"
	description = "Backend Bucket for prod site"
	bucket_name = "${google_storage_bucket.prod_site_bucket.name}"
	enable_cdn  = true
}

output "prod_backend" {
	value = "${google_compute_backend_bucket.prod_backend.self_link}"
}

resource "google_storage_bucket" "testing_site_bucket" {
	name     = "${replace("${var.domain}", ".", "-")}-testing-site"
	location = "${var.region}"

	website {
		main_page_suffix = "${var.main_page_suffix}"
		not_found_page   = "${var.not_found_page}"
	}
}

resource "google_storage_bucket_iam_member" "testing_site_iam_member" {
	bucket = "${google_storage_bucket.testing_site_bucket.name}"
	role   = "roles/storage.objectViewer"
	member = "allUsers"
}

resource "google_compute_backend_bucket" "testing_backend" {
	name        = "${replace("${var.domain}", ".", "-")}-testing-backend"
	description = "Backend Bucket for testing site"
	bucket_name = "${google_storage_bucket.testing_site_bucket.name}"
}

output "testing_backend" {
	value = "${google_compute_backend_bucket.testing_backend.self_link}"
}
