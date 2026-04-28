

# Configure the AWS Provider






#Create a s3 bucket
 resource "aws_s3_bucket" "The-demo-bucket" {
  bucket = local.bucket_name

  tags = {
    Name        = local.bucket_name 
    Environment = var.envi
  }
}
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.1.0/24"

  tags={
    Name = local.vpc_name    
    Enviornment = local.vpc_name
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
  instance_type = "t3.micro"

  tags = {
    Enviornment = var.envi
    Name        = "${var.envi} EC2 Instance"
  }
}
