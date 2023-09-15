variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default = "qxf2-bucket"
}

variable "github_repo" {
  description = "The GitHub repository URL"
  type        = string
  default = "nelabhotlaR/terraform_exercises_20230808"
}

variable "github_file_path" {
  description = "The file path in the GitHub repository"
  type        = string
  default = "templates/s3_sample.txt"
}
