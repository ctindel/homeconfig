resource "aws_s3_bucket" "s3_softwareinblue_com_bucket" {
  bucket = "${var.r53_domain}"
  acl = "public-read"
  tags {
    Name = "${var.r53_domain}"
  }
  versioning {
    enabled = true
  }
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket" "s3_www_softwareinblue_com_bucket" {
  bucket = "www.${var.r53_domain}"
  acl = "public-read"
  tags {
    Name = "www.${var.r53_domain}"
  }
}
