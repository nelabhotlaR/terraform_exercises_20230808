variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "qxf2-bucket-01"
}

variable "bucket_environment" {
  default = "The environment name"
  type    = string
}

variable "github_repo" {
  description = "The GitHub repository URL"
  type        = string
  default     = "nelabhotlaR/terraform_exercises_20230808"
}

variable "github_file_path" {
  description = "The file path in the GitHub repository"
  type        = string
  default     = "templates/sample.txt"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "profile" {
  type    = string
  default = "personal"
}
