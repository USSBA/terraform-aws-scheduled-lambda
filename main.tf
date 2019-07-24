terraform {
  required_version = "~> 0.12.5"
  required_providers {
    aws     = "~> 2.13"
    archive = "~> 1.2.2"
  }
}
locals {
  enabled_count = var.enabled ? 1 : 0
}
