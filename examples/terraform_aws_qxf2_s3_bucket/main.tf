# Create a s3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "qxf2-terraform-test-bucket"
  tags = {
        Name = "test bucket"
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "versioning_test_bucket" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Add files/objects into the bucket
resource "aws_s3_object" "objects" {
  for_each = fileset("${var.OBJECTS_PATH}", "*")
  bucket = aws_s3_bucket.bucket.id
  key    = each.value
  source = "${var.OBJECTS_PATH}/${each.value}"
}
