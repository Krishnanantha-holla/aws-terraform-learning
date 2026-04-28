terraform {
  

  backend "s3" {
    bucket = "krishnanantha-tf-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
  }