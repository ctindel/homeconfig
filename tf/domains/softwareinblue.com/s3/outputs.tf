# S3
output "softwareinblue_com_s3_bucket_id" {
  value = "${aws_s3_bucket.s3_softwareinblue_com_bucket.id}"
}

output "softwareinblue_com_s3_bucket_website_domain" {
  value = "${aws_s3_bucket.s3_softwareinblue_com_bucket.website_domain}"
}

output "softwareinblue_com_s3_bucket_website_endpoint" {
  value = "${aws_s3_bucket.s3_softwareinblue_com_bucket.website_endpoint}"
}

output "softwareinblue_com_s3_bucket_hosted_zone_id" {
  value = "${aws_s3_bucket.s3_softwareinblue_com_bucket.hosted_zone_id}"
}

output "www_softwareinblue_com_s3_bucket_id" {
  value = "${aws_s3_bucket.s3_www_softwareinblue_com_bucket.id}"
}

output "www_softwareinblue_com_s3_bucket_website_domain" {
  value = "${aws_s3_bucket.s3_www_softwareinblue_com_bucket.website_domain}"
}

output "www_softwareinblue_com_s3_bucket_website_endpoint" {
  value = "${aws_s3_bucket.s3_www_softwareinblue_com_bucket.website_endpoint}"
}

output "www_softwareinblue_com_s3_bucket_hosted_zone_id" {
  value = "${aws_s3_bucket.s3_www_softwareinblue_com_bucket.hosted_zone_id}"
}
