# Create an S3 bucket
resource "aws_s3_bucket" "Qxf2_bucket-01" {
  bucket = var.bucket_name
  tags = {
    Name        = var.bucket_name
    Environment = var.bucket_environment
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "versioning_test_bucket" {
  bucket = aws_s3_bucket.Qxf2_bucket-01.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "acl_test_bucket" {
  bucket     = aws_s3_bucket.Qxf2_bucket-01.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.Qxf2_bucket-01.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

# Configure the GitHub repository as a data source
data "github_repository" "repo" {
  full_name = var.github_repo
}

# Define the URL to fetch the file from GitHub
locals {
  github_file_url = "https://raw.githubusercontent.com/${data.github_repository.repo.full_name}/${var.github_file_path}"
}

# Create an S3 object to upload the file
resource "aws_s3_object" "my_file" {
  bucket = aws_s3_bucket.Qxf2_bucket-01.id
  key    = "sample.txt"
  //source = local.github_file_url
  content = data.github_repository.repo.full_name

  acl        = "private"
  depends_on = [aws_s3_bucket.Qxf2_bucket-01] # Ensure the bucket is created before uploading the file
}


//https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply