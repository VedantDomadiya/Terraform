terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }

  backend "s3" {
    bucket = "my-s3-bucket-for-remote-backend"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "my_dynamodb_for_remote_backend"
  }
}

provider "aws" {
  region = var.aws_region
}