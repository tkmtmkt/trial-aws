terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}
