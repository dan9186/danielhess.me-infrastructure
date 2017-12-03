resource "google_dns_managed_zone" "domain" {
	name        = "danielhess-domain"
	dns_name    = "danielhess.me."
	description = "Danielhess.me Domain"
}

resource "google_dns_record_set" "www_dns" {
	name = "www.${google_dns_managed_zone.domain.dns_name}"
	type = "CNAME"
	ttl  = 300

	managed_zone = "${google_dns_managed_zone.domain.name}"

	rrdatas = ["c.storage.googleapis.com."]
}

resource "google_dns_record_set" "new_dns" {
	name = "new.${google_dns_managed_zone.domain.dns_name}"
	type = "CNAME"
	ttl  = 300

	managed_zone = "${google_dns_managed_zone.domain.name}"

	rrdatas = ["c.storage.googleapis.com."]
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
