resource "google_dns_managed_zone" "zone" {
	name        = "${replace("${var.domain}", ".", "-")}-zone"
	dns_name    = "${var.domain}."
	description = "Managed zone for ${var.domain}"
}

resource "google_dns_record_set" "prod_dns" {
	name = "${var.prod_subdomain}.${var.domain}."
	type = "A"
	ttl  = 300

	managed_zone = "${google_dns_managed_zone.zone.name}"

	rrdatas = ["${var.ip_addresses}"]
}

output "prod_dns" {
	value = "${var.prod_subdomain}.${var.domain}"
}

resource "google_dns_record_set" "testing_dns" {
	name = "${var.testing_subdomain}.${var.domain}."
	type = "A"
	ttl  = 300

	managed_zone = "${google_dns_managed_zone.zone.name}"

	rrdatas = ["${var.ip_addresses}"]
}

output "testing_dns" {
	value = "${var.testing_subdomain}.${var.domain}"
}

resource "google_dns_record_set" "mail_record" {
	name = "@.${google_dns_managed_zone.zone.dns_name}"
	type = "MX"
	ttl  = 300

	managed_zone = "${google_dns_managed_zone.zone.name}"

	rrdatas = [
		"1 aspmx.l.google.com.",
		"5 alt1.aspmx.l.google.com.",
		"5 alt2.aspmx.l.google.com.",
		"10 alt3.aspmx.l.google.com.",
		"10 alt4.aspmx.l.google.com."
	]
}
