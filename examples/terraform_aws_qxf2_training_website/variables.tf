# region in which the instance going to be deployed.
variable "region" {
    description = "Qxf2 training website ec2 instance deploy region"
    type = string
    default = "us-east-1"
}

variable "training_website_ec2_inst_type" {
    description = "declaring ec2 instance type for is-pto-service for dev, test and prod"
    type = string
    default = "t3.micro"
}
/*
# PEM file name to ssh into instance.
variable "training_website_key_pair" {
    description = "defining the PEM key file name to ssh into ec2 instance"
    type = string
    default = "trainingwebsite"
}

variable "profile" {
    default = "personal"
    type = string

}
*/

# to declare private key path
variable "private_key_path" {
  type        = string
  description = "Path to the PEM private key file"
  default = "~/.ssh/terraform"
}

variable "public_key_path" {
  type        = string
  description = "Path to the public key file"
  default = "~/.ssh/terraform.pub"
}