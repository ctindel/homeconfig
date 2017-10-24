# S3
output "dashboard_city_s3_bucket_id" {
  value = "${aws_s3_bucket.s3_dashboard_city_bucket.id}"
}

