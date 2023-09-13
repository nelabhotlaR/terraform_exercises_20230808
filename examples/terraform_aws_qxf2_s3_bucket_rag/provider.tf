terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    github = {
      source  = "integrations/github"
      version =  "5.36.0"
    }
    }
  }

# Include the AWS provider
provider "aws" {}
provider "github" {}