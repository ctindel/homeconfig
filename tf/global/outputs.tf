# S3
output "ctindel_s3_bucket_id" {
  value = "${module.s3.ctindel_s3_bucket_id}"
}

output "ctindel_s3_bucket_replica_id" {
  value = "${module.s3.ctindel_s3_bucket_replica_id}"
}
