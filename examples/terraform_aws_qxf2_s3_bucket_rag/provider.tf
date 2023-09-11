terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.4.0"
    }
    }
  }

# Include the AWS provider
provider "aws" {
  region = "us-east-1"  # Change this to your desired region
  #profile = "personal"
}