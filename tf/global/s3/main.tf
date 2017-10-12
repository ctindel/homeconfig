resource "aws_iam_role" "s3_bucket_replication" {
  name               = "${var.s3_bucket_prefix}-repl-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "s3_bucket_replication" {
    name = "${var.s3_bucket_prefix}-repl-policy"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.ctindel_s3_bucket.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.ctindel_s3_bucket.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.ctindel_s3_bucket_replica.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "replication" {
    name = "${var.s3_bucket_prefix}-repl-policy-attachment"
    roles = ["${aws_iam_role.s3_bucket_replication.name}"]
    policy_arn = "${aws_iam_policy.s3_bucket_replication.arn}"
}

resource "aws_s3_bucket" "ctindel_s3_bucket" {
  bucket  = "${var.s3_bucket_prefix}-${var.region}"
  acl     = "private"
  region  = "${var.region}"

  tags {
    Name = "${var.s3_bucket_prefix}-${var.region}"
    Type = "Primary"
  }
  versioning {
    enabled = true
  }
  force_destroy = false
  replication_configuration {
    role = "${aws_iam_role.s3_bucket_replication.arn}"
    rules {
      id     = "s3_bucket_replication_rule"
      prefix = ""
      status = "Enabled"

      destination {
        bucket        = "${aws_s3_bucket.ctindel_s3_bucket_replica.arn}"
        storage_class = "STANDARD"
      }
    }
  }
}

resource "aws_s3_bucket" "ctindel_s3_bucket_replica" {
  provider = "aws.region_backup"
  bucket  = "${var.s3_bucket_prefix}-${var.region_backup}-replica"
  acl     = "private"
  region  = "${var.region_backup}"

  tags {
    Name = "${var.s3_bucket_prefix}-${var.region_backup}-replica"
    Type = "Replica"
    purpose = "Replica of ${var.s3_bucket_prefix}-${var.region}"
  }
  versioning {
    enabled = true
  }
  force_destroy = true
}

resource "aws_s3_bucket" "s3_tindel_net_bucket" {
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
