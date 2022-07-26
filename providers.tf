terraform {
  #backend "s3" {
  #  bucket = "example-terraform-state"
  #  region = "us-east-1"
  #  key = "terraform.tfstate"
  # encrypt = true
  #}
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["/Users/hxue/.aws/credentials"]
  profile                  = "kaisya"
}