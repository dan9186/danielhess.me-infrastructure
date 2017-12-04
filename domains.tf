resource "google_dns_managed_zone" "domain" {
	name        = "managed-domain"
	dns_name    = "${var.domain}."
	description = "Domain Name"
}

resource "google_dns_record_set" "prod_dns" {
	name = "${var.prod_subdomain}.${var.domain}."
	type = "A"
	ttl  = 300

	managed_zone = "${google_dns_managed_zone.domain.name}"

	rrdatas = ["${google_compute_global_forwarding_rule.site_forwarding_rule.ip_address}"]
}

resource "google_dns_record_set" "testing_dns" {
	name = "${var.testing_subdomain}.${var.domain}."
	type = "A"
	ttl  = 300

	managed_zone = "${google_dns_managed_zone.domain.name}"

	rrdatas = ["${google_compute_global_forwarding_rule.site_forwarding_rule.ip_address}"]
}

resource "google_dns_record_set" "mail_record" {
	name = "@.${google_dns_managed_zone.domain.dns_name}"
	type = "MX"
	ttl  = 300

	managed_zone = "${google_dns_managed_zone.domain.name}"

	rrdatas = [
		"1 aspmx.l.google.com.",
		"5 alt1.aspmx.l.google.com.",
		"5 alt2.aspmx.l.google.com.",
		"10 alt3.aspmx.l.google.com.",
		"10 alt4.aspmx.l.google.com."
	]
}
