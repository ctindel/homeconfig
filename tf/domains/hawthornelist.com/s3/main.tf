resource "aws_s3_bucket" "s3_hawthornelist_com_bucket" {
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

  website {
    index_document = "index.html"
  }

  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
    "Sid":"PublicReadForGetBucketObjects",
    "Effect":"Allow",
    "Principal": "*",
    "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.r53_domain}/*"]
    }
  ]
}
EOF

}
