resource "aws_route53_record" "domain" {
  zone_id = "${var.r53_zone_id}"
  name    = "${var.dns_domain}"
  type    = "A"
  ttl     = "86048"
  records = ["209.68.15.160"]
}

resource "aws_route53_record" "www_tindel_net" {
  zone_id = "${var.r53_zone_id}"
  name    = "www"
  type    = "A"
  ttl     = "86048"
  records = ["209.68.15.160"]
}

resource "aws_route53_record" "router_tindel_net" {
  zone_id = "${var.r53_zone_id}"
  name    = "router"
  type    = "A"
  ttl     = "86048"
  records = ["67.243.183.129"]
}

resource "aws_route53_record" "tindel_net_mx" {
  zone_id = "${var.r53_zone_id}"
  name    = "${var.dns_domain}"
  type    = "MX"
  ttl     = "86048"
  records = ["1 aspmx.l.google.com",
             "5 alt1.aspmx.l.google.com",
             "5 alt2.aspmx.l.google.com",
             "10 aspmx1.googlemail.com",
             "10 aspmx2.googlemail.com"]
}
