terraform {
    
  backend "s3" {
    bucket = "krishnanantha-tf-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }

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
variable "envi" {
  default = "dev"
  type    = string
}


#Create a s3 bucket
resource "aws_s3_bucket" "The-demo-bucket" {
  bucket = "my-first-bucket-hell-yeah"

  tags = {
    Name        = "My bucket Here"
    Environment = var.envi
  }
}