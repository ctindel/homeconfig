variable "region" {
  default = "us-east-2"
}

variable "region_backup" {
  default = "us-west-2"
}

variable "s3_bucket_prefix" {
  default = "ctindel"
  description = "The bucket name we store our stuff in"
}

