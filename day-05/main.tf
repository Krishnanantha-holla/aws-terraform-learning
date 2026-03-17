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

locals {
  env=var.envi
  bucket_name = "${var.envi}-bucket"
  vpc_name = "${var.envi}-vpc"
  ec2_name = "${var.envi} EC2 Instance"
}


#Create a s3 bucket
 resource "aws_s3_bucket" "The-demo-bucket" {
  bucket = "my-first-bucket-hell-yeahh"

  tags = {
    Name        = "${var.envi}-bucket "
    Environment = var.envi
  }
}
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.1.0/24"

  tags={
    Name = "${var.envi}-vpc"    
    Enviornment = var.envi
  }
  
}

resource "aws_subnet" "sample" {
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = "10.0.1.0/25"
  availability_zone = "us-east-1a"

  tags = {
    Name        = "${var.envi}-subnet"
    Environment = var.envi
  }
}

# CORRECTION: Fetch a valid AMI for the configured region instead of hardcoding one.
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "les-go" {
  ami           = data.aws_ami.amazon_linux_2.id # CORRECTION: Use looked-up AMI ID.
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.sample.id

  tags = {
    Enviornment = var.envi
    Name        = "${var.envi} EC2 Instance"
  }
}