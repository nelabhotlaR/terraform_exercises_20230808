variable "aws_region" {
  description = "AWS region where the EC2 instance should be created"
  type        = string
  default     = "us-east-1"
}

variable "profile_name" {

}

variable "ssh_public_key" {
  type        = string
  description = "The path of the SSH public key file"
  default     = "~/.ssh/id_rsa.pub"
}