module "network" {
  source          = "./network"
  access_ip       = var.access_ip
  vpc_cidr        = local.vpc_cidr
  security_groups = local.security_groups
}

module "ec2" {
  source        = "./ec2"
  public_sg     = module.network.public_sg
  public_subnet = module.network.public_subnet
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "haoxue-terraform-state"
  acl = "private"
}

resource "aws_s3_bucket_versioning" "hx_s3_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
/*
resource "aws_s3_bucket_acl" "S3_acl_hxue" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}
*/
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform_state_lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}