resource "aws_route53_record" "dashboard_city" {
  zone_id = "${var.r53_zone_id}"
  name    = "${var.dns_domain}"
  type    = "A"
  ttl     = "86048"
  records = ["192.81.135.42"]
}

resource "aws_route53_record" "www_dashboard_city" {
  zone_id = "${var.r53_zone_id}"
  name    = "www"
  type    = "CNAME"
  ttl     = "86048"
  records = ["${var.dns_domain}"]
}

resource "aws_route53_record" "calendar_dashboard_city" {
  zone_id = "${var.r53_zone_id}"
  name    = "calendar"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "docs_dashboard_city" {
  zone_id = "${var.r53_zone_id}"
  name    = "docs"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "mail_dashboard_city" {
  zone_id = "${var.r53_zone_id}"
  name    = "mail"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "start_dashboard_city" {
  zone_id = "${var.r53_zone_id}"
  name    = "start"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "dashboard_city_mx" {
  zone_id = "${var.r53_zone_id}"
  name    = "${var.dns_domain}"
  type    = "MX"
  ttl     = "3600"
  records = ["1 aspmx.l.google.com",
             "5 alt1.aspmx.l.google.com",
             "5 alt2.aspmx.l.google.com",
             "10 alt3.aspmx.l.google.com",
             "10 alt4.aspmx.l.google.com"]
}
