variable "region" {
  default = "us-east-2"
}

variable "region_backup" {
  default = "us-west-2"
}

variable "r53_domain" {
  default = "tindel.net"
}

variable "r53_zone_id" {
  default = "Z1X49B7PWY47HD"
}

variable "s3_bucket_prefix" {
  default = "ctindel"
  description = "The bucket name we store our stuff in"
}

