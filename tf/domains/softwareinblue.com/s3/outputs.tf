# S3
output "softwareinblue_com_s3_bucket_id" {
  value = "${aws_s3_bucket.s3_softwareinblue_com_bucket.id}"
}

output "www_softwareinblue_com_s3_bucket_id" {
  value = "${aws_s3_bucket.s3_www_softwareinblue_com_bucket.id}"
}
