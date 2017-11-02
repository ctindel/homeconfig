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

module "tindel_net" {
    source           = "./domains/tindel.net"
    region           = "${var.region}"
    s3_bucket_prefix = "${var.s3_bucket_prefix}"
}

module "learningfromthelegends_com" {
    source           = "./domains/learningfromthelegends.com"
    region           = "${var.region}"
    s3_bucket_prefix = "${var.s3_bucket_prefix}"
}

module "hawthornelist_com" {
    source           = "./domains/hawthornelist.com"
    region           = "${var.region}"
    s3_bucket_prefix = "${var.s3_bucket_prefix}"
}

module "hawthornlist_com" {
    source           = "./domains/hawthornlist.com"
    region           = "${var.region}"
    s3_bucket_prefix = "${var.s3_bucket_prefix}"
}

module "tindelmg_com" {
    source           = "./domains/tindelmg.com"
    region           = "${var.region}"
    s3_bucket_prefix = "${var.s3_bucket_prefix}"
}

module "cardiacnp_com" {
    source           = "./domains/cardiacnp.com"
    region           = "${var.region}"
    s3_bucket_prefix = "${var.s3_bucket_prefix}"
}

module "s3" {
  source = "./s3"

  region              = "${var.region}"
  region_backup       = "${var.region_backup}"
  s3_bucket_prefix    = "${var.s3_bucket_prefix}"
}
