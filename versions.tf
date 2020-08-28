terraform {
  required_version = "~> 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.13, < 4.0.0" # Confirmed compatible with hashicorp/aws 2.* and 3.*
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 1.2"
    }
  }
}
