terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.64"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "0.58.0"
    }
  }
}
