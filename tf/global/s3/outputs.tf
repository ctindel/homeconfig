# S3
output "ctindel_s3_bucket_id" {
  value = "${aws_s3_bucket.ctindel_s3_bucket.id}"
}

output "ctindel_s3_bucket_replica_id" {
  value = "${aws_s3_bucket.ctindel_s3_bucket_replica.id}"
}
