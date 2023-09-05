
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key"
  type        = string
  default     = "access-key-id"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret access key"
  type        = string
  default     = "secret-access-key"
}

variable "domain_name" {
  type    = string
  default = "test-resource-ses.com"
}

variable "name" {
  type    = string
  default = "test-resource-SES"
}

variable "rule_set_name" {
  type    = string
  default = "default-rule-set"
}