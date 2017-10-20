resource "aws_route53_record" "tindel_net" {
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
  ttl     = "3600"
  records = ["1 aspmx.l.google.com",
             "5 alt1.aspmx.l.google.com",
             "5 alt2.aspmx.l.google.com",
             "10 alt3.aspmx.l.google.com",
             "10 alt4.aspmx.l.google.com"]
}
