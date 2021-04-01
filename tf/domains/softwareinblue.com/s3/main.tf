resource "aws_s3_bucket" "s3_softwareinblue_com_bucket" {
  bucket = "${var.r53_domain}"
  #acl = "public-read"
  acl = "private"
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

  website {
    index_document = "index.html"
  }
  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://${var.r53_domain}"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  	bucket = "${aws_s3_bucket.s3_softwareinblue_com_bucket.id}"
  	policy = "${data.aws_iam_policy_document.s3_softwareinblue_com_cf_policy.json}"
}

data "aws_iam_policy_document" "s3_softwareinblue_com_cf_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_softwareinblue_com_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${var.cf_oai_arn}"]
    }
  }
}

resource "aws_s3_bucket" "s3_www_softwareinblue_com_bucket" {
  bucket = "www.${var.r53_domain}"
  acl = "public-read"
  tags {
    Name = "www.${var.r53_domain}"
  }
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:ListBucket"],
      "Resource":["arn:aws:s3:::www.${var.r53_domain}"]
    },
    {
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::www.${var.r53_domain}/*"]
    }
  ]
}
POLICY

  website {
    redirect_all_requests_to = "https://${var.r53_domain}"
  }
}
