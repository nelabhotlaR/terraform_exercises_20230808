variable "aws_region" {
  description = "AWS region where the EC2 instance should be created"
  type        = string
  default     = "ap-south-1"
}

variable "profile_name" {
  type = string
  description = "The name of the AWS profile to use"
  default = "default"
}

variable "ssh_public_key" {
  type        = string
  description = "The path of the SSH public key file"
  default = "~/.ssh/id_rsa.pub"
}