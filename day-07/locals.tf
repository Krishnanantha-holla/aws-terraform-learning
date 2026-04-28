locals {
  env=var.envi
  bucket_name = "${var.envi}-bucket"
  vpc_name = "${var.envi}-vpc"
  ec2_name = "${var.envi} EC2 Instance"
}