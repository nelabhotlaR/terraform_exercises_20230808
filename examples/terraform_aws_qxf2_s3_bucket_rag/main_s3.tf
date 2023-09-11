# Create an S3 bucket
resource "aws_s3_bucket" "Qxf2_bucket" {
  bucket = var.bucket_name
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "versioning_test_bucket" {
  bucket = aws_s3_bucket.Qxf2_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "acl_test_bucket" {
    bucket = aws_s3_bucket.Qxf2_bucket.id
    acl = "private"
}

# Configure the GitHub repository as a data source
data "github_repository" "repo" {
  full_name = var.github_repo
}

# Define the URL to fetch the file from GitHub
locals {
  github_file_url = "https://raw.githubusercontent.com/${data.github_repository.repo.full_name}/master/${var.github_file_path}"
}

# Create an S3 object to upload the file
resource "aws_s3_object" "my_file" {
  bucket = aws_s3_bucket.Qxf2_bucket.id
  key    = var.github_file_path
  source = local.github_file_url

  acl    = "private"
  depends_on = [aws_s3_bucket.Qxf2_bucket]  # Ensure the bucket is created before uploading the file
}


