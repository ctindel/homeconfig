# S3
output "scene_fm_s3_bucket_id" {
  value = "${aws_s3_bucket.s3_scene_fm_bucket.id}"
}

