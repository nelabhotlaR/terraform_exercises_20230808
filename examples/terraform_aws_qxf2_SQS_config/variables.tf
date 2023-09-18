# aws config values
variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "qxf2-test-queue"
}

variable "AWS_REGION" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
/*
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key"
  type        = string
  default     = "AWS access key"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret access key"
  type        =  string
  default     = "AWS secret access key"
}*/