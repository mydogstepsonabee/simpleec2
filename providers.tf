terraform {
  backend "s3" {
    bucket         = "haoxue-terraform-state"
    region         = "us-east-1"
    key            = "terraform.tfstate"
    encrypt        = true
    profile        = "kaisya"
    dynamodb_table = "terraform_state_lock"
  }
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
  default_tags {
    tags = {
      Name  = "hao-demo"
      Owner = "tenable.cs"
    }
  }
}