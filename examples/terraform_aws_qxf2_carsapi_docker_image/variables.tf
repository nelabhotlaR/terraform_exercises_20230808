variable "aws_region" {
  description = "AWS region where the EC2 instance should be created"
  type        = string
  default     = "us-east-1"
}

variable "profile_name" {
  type        = string
  description = "The name of the AWS profile to use"
  default     = "personal"
}

variable "ssh_public_key" {
  type        = string
  description = "The path of the SSH public key file"
  default     = "~/.ssh/id_rsa.pub"
}