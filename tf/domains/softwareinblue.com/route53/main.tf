resource "aws_route53_record" "softwareinblue_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "${var.dns_domain}"
  type    = "A"

  alias {
    name                   = "${var.softwareinblue_com_cf_domain}"
    zone_id                = "${var.softwareinblue_com_cf_hosted_zone_id}"
    #name                   = "${var.softwareinblue_com_s3_bucket_website_domain}"
    #zone_id                = "${var.softwareinblue_com_s3_bucket_hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www_softwareinblue_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "www"
  type    = "A"

  alias {
    #name                   = "${var.softwareinblue_com_cf_domain}"
    #zone_id                = "${var.softwareinblue_com_cf_hosted_zone_id}"
    name                   = "${var.www_softwareinblue_com_s3_bucket_website_domain}"
    zone_id                = "${var.www_softwareinblue_com_s3_bucket_hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "calendar_softwareinblue_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "calendar"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "docs_softwareinblue_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "docs"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "mail_softwareinblue_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "mail"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "start_softwareinblue_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "start"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "blog_softwareinblue_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "blog"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.googlehosted.com"]
}

resource "aws_route53_record" "softwareinblue_com_mx" {
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
