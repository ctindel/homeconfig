#resource "aws_route53_record" "learningfromthelegends_com" {
  #zone_id = "${var.r53_zone_id}"
  #name    = "${var.dns_domain}"
  #type    = "A"
  #ttl     = "86048"
  #records = ["185.199.108.153", "185.199.109.153", "185.199.110.153", "185.199.111.153"]
#}

#resource "aws_route53_record" "www_learningfromthelegends_com" {
  #zone_id = "${var.r53_zone_id}"
  #name    = "www"
  #type    = "CNAME"
  #ttl     = "86048"
  #records = ["ctindel.github.io"]
#}

resource "aws_route53_record" "calendar_learningfromthelegends_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "calendar"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "docs_learningfromthelegends_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "docs"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "mail_learningfromthelegends_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "mail"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "start_learningfromthelegends_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "start"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.google.com"]
}

resource "aws_route53_record" "blog_learningfromthelegends_com" {
  zone_id = "${var.r53_zone_id}"
  name    = "blog"
  type    = "CNAME"
  ttl     = "86048"
  records = ["ghs.googlehosted.com"]
}

resource "aws_route53_record" "learningfromthelegends_com_mx" {
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
