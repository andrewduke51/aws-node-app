## datasources ##
data "external" "current_ip" {
  program = ["python", "../${path.module}/ops/ip.py"]
}
data "aws_vpc" "vpc_cidr" {
  id = module.vpc.vpc_id
}
data "aws_ami" "ec2" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["node-app-*"]
  }
}
# Create a VPC using a remote module in github
module "vpc" {
  source          = "git::https://github.com/andrewduke51/vpc-module.git"
  subnet_dmz      = var.subnet_dmz
  subnet_internal = var.subnet_internal
  subnet_vpc      = var.subnet_vpc
  auto_assign_ip  = true
}
## KMS ##
resource "aws_kms_key" "general_bucket_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}
resource "aws_kms_alias" "key-alias" {
  name          = "alias/general-bucket-key"
  target_key_id = aws_kms_key.general_bucket_key.key_id
}
## S3 ##
resource "aws_s3_bucket" "general" {
  bucket = "temporaryunsomerandomeatdelete"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.general.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.general_bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.general.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
## DYNAMODB ##
resource "aws_dynamodb_table" "general_table" {
  name           = "general-table"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}