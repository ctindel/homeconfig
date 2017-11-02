# S3
output "cardiacnp_com_s3_bucket_id" {
  value = "${aws_s3_bucket.s3_cardiacnp_com_bucket.id}"
}

