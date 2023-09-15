variable "public_key_path" {
  type        = string
  description = "Path to the public key file"
  default = "~/.ssh/terraform.pub"
}