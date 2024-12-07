# terraform
terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket  = "tastylog-tfstate-bucket-00072"
    key     = "tastylog-dev.tfstate"
    region  = "ap-northeast-1"
    profile = "terraform"
  }
}

# Provider: AWS
provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

# variables
variable "project" {
  type = string
}

variable "environment" {
  type = string
}
