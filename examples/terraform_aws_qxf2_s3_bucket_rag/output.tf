# Output the S3 bucket URL
output "s3_bucket_url" {
  value = aws_s3_bucket.Qxf2_bucket-01.arn
}