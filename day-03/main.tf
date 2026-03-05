terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


#Create a s3 bucket
resource "aws_s3_bucket" "The-demo-bucket" {
  bucket = "my-first-bucket-hell-yeah"

  tags = {
    Name        = "My bucket Here"
    Environment = "Dev"
  }
}