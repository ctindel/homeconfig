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

module "route53" {
  source = "./route53"

  region          = "${var.region}"
  dns_domain      = "${var.r53_domain}"
  r53_zone_id     = "${var.r53_zone_id}"
}

module "s3" {
  source = "./s3"

  region              = "${var.region}"
  s3_bucket_prefix    = "${var.s3_bucket_prefix}"
  r53_domain          = "${var.r53_domain}"
}
