resource "aws_route53_record" "cardiacnp_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "${var.dns_domain}"
  type    = "A"
  ttl     = "86048"
  records = ["216.239.32.21", "216.239.34.21", "216.239.36.21", "216.239.38.21"]
}

resource "aws_route53_record" "calendar_cardiacnp_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "calendar"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "docs_cardiacnp_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "docs"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "mail_cardiacnp_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "mail"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "start_cardiacnp_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "start"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "www_cardiacnp_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "www"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "cardiacnp_com_mx" {
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
