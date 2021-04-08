data "terraform_remote_state" "global" {
  backend = "s3"

  config {
    region  = "${var.region}"
    bucket  = "${var.s3_bucket_prefix}-${var.region}"
    key     = "demos/terraform/env/global/terraform.tfstate"
  }
}

provider "aws" {
  region = "${var.region}"
}

# Cert has to be in us-east-1 to work with cloudfront
data "aws_acm_certificate" "softwareinblue_com_cert" {
  provider = "aws.us-east-1"
  domain = "${var.r53_domain}"
  statuses = ["ISSUED"]
}

resource "aws_cloudfront_origin_access_identity" "softwareinblue_com_oai" {
}

resource "aws_cloudfront_origin_access_identity" "www_softwareinblue_com_oai" {
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    origin_id   = "${var.r53_domain}"
    domain_name = "${var.r53_domain}.s3.amazonaws.com"
    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.softwareinblue_com_oai.cloudfront_access_identity_path}"
    }
  }

  # If using route53 aliases for DNS we need to declare it here too, otherwise we'll get 403s.
  aliases = ["${var.r53_domain}"]

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.r53_domain}"

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    # Cloudfront doesn't properly request subdirectory index.html files so we
    # need to have this lambda function rewrite them
    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = "${aws_lambda_function.index_rewrite_lambda.qualified_arn}"
    }
  }

  # The cheapest priceclass
  price_class = "PriceClass_100"

  # This is required to be specified even if it's not used.
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.softwareinblue_com_cert.arn}"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}

resource "aws_cloudfront_distribution" "www_cdn" {
  origin {
    origin_id   = "S3-www.${var.r53_domain}"
    # This doesn't work if you use the normal website_name here you have to
    # give the region specific s3-website name.  But we have to be able to
    # create this distribution before we create the underlying bucket so
    # there's a circular dependency problem.  The first time you apply this
    # just switch these domain names, and then once the s3 bucket exists you
    # can switch it back.
    domain_name = "${module.s3.www_softwareinblue_com_s3_bucket_website_endpoint}"
    #domain_name = "www.${var.r53_domain}.s3-website.${var.region}.amazonaws.com"
    custom_origin_config {
      http_port = "80"
      https_port = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  # If using route53 aliases for DNS we need to declare it here too, otherwise we'll get 403s.
  aliases = ["www.${var.r53_domain}"]

  enabled             = true
  is_ipv6_enabled     = true
  # no default_root_object for the redirect bucket
  #default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-www.${var.r53_domain}"

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # The cheapest priceclass
  price_class = "PriceClass_100"

  # This is required to be specified even if it's not used.
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.softwareinblue_com_cert.arn}"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}

module "route53" {
  source = "./route53"

  region          = "${var.region}"
  dns_domain      = "${var.r53_domain}"
  r53_zone_id     = "${var.r53_zone_id}"
  softwareinblue_com_cf_domain = "${aws_cloudfront_distribution.cdn.domain_name}"
  softwareinblue_com_cf_hosted_zone_id = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
#  softwareinblue_com_s3_bucket_id = "${module.s3.softwareinblue_com_s3_bucket_id}"
#  softwareinblue_com_s3_bucket_website_domain = "${module.s3.softwareinblue_com_s3_bucket_website_domain}"
#  softwareinblue_com_s3_bucket_hosted_zone_id = "${module.s3.softwareinblue_com_s3_bucket_hosted_zone_id}"
  www_softwareinblue_com_cf_domain = "${aws_cloudfront_distribution.www_cdn.domain_name}"
  www_softwareinblue_com_cf_hosted_zone_id = "${aws_cloudfront_distribution.www_cdn.hosted_zone_id}"
  www_softwareinblue_com_s3_bucket_id = "${module.s3.www_softwareinblue_com_s3_bucket_id}"
  www_softwareinblue_com_s3_bucket_website_domain = "${module.s3.www_softwareinblue_com_s3_bucket_website_domain}"
  www_softwareinblue_com_s3_bucket_hosted_zone_id = "${module.s3.www_softwareinblue_com_s3_bucket_hosted_zone_id}"
}

module "s3" {
  source = "./s3"

  region              = "${var.region}"
  s3_bucket_prefix    = "${var.s3_bucket_prefix}"
  r53_domain          = "${var.r53_domain}"
  cf_oai_arn          = "${aws_cloudfront_origin_access_identity.softwareinblue_com_oai.iam_arn}"
}

#resource "aws_iam_role" "lambda_edge_exec" {
#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": "sts:AssumeRole",
#      "Principal": {
#        "Service": ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
#      },
#      "Effect": "Allow"
#    }
#  ]
#}
#EOF
#}

data "archive_file" "index_rewrite_zip" {
  type        = "zip"
  source_file  = "${path.module}/index_rewrite_lambda/handler.js"
  output_path = "${path.module}/index_rewrite_lambda/deployment.zip"
}

resource "aws_iam_role" "index_rewrite_lambda_role" {
  name = "index_rewrite_lambda_role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = "${aws_iam_role.index_rewrite_lambda_role.id}"

  # logs:CreateLogGroup is omitted so terraform can manage the log
  # group and set a retention policy, we don't want the
  # lambda function creating this group and having no
  # no retention policy
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "arn:aws:logs:*:*:*"
        ]
      }
    ]
  }
  EOF
}

resource "aws_lambda_function" "index_rewrite_lambda" {
	# ...
  provider      = "aws.us-east-1"
  publish       = true
  filename      = "${path.module}/index_rewrite_lambda/deployment.zip"
  function_name = "softwareinblue_index_rewrite"
  role          = "${aws_iam_role.index_rewrite_lambda_role.arn}"
  handler       = "handler.handler"

  source_code_hash = "${data.archive_file.index_rewrite_zip.output_base64sha256}"
  runtime       = "nodejs12.x"
}

resource "aws_cloudwatch_log_group" "loggroup" {
  # Don't ask me why the region name is prepended to the lambda function I have
  # no idea
  provider      = "aws.us-east-1"
  name              = "/aws/lambda/us-east-1.${aws_lambda_function.index_rewrite_lambda.function_name}"
  retention_in_days = 14
}

