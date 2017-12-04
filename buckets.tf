resource "google_storage_bucket" "www-site" {
	name     = "www.danielhess.me"
	location = "${var.region}"

	website {
		main_page_suffix = "index.html"
		not_found_page   = "index.html"
	}
}

resource "google_storage_bucket" "new-site" {
	name     = "new.danielhess.me"
	location = "${var.region}"

	website {
		main_page_suffix = "index.html"
		not_found_page   = "index.html"
	}
}
