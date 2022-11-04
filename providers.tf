terraform {
  cloud {
    organization = "tcslimited"
    workspaces {
      name = "project1"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  //shared_credentials_files = ["/Users/hxue/.aws/credentials"]
  //profile                  = "kaisya"
  //
}