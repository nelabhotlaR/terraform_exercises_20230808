output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.bucket.id
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = aws_s3_bucket.bucket.region
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.bucket.arn
}

output "s3_bucket_policy"{
   description ="The policy of the bucket, if the bucket is configured with a policy. If not, this will be an empty string."
   value       = aws_s3_bucket.bucket.policy
}
