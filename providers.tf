terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  //shared_credentials_files = ["/Users/hxue/.aws/credentials"]
  //profile                  = "kaisya"
  
}