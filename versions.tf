terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.68, < 4.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 1.2.2"
    }
  }
}
