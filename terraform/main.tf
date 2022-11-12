terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "temporaryunsomerandomeatdelete"
    key            = "tf/general.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/general-bucket-key"
    dynamodb_table = "general-table"
  }
}