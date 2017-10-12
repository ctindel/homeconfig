terraform {
  backend "s3" {
      bucket = "ctindel-us-east-2"
      key = "terraform/env/global/terraform.tfstate"
      region = "us-east-2"
  }
}

provider "aws" {
  region = "${var.region}"
}

provider "aws" {
    alias = "region_backup"
    region = "${var.region_backup}"
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
  region_backup       = "${var.region_backup}"
  s3_bucket_prefix    = "${var.s3_bucket_prefix}"
  r53_domain          = "${var.r53_domain}"
}
