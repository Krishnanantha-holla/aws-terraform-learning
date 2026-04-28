variable "envi" {
  default = "dev"
  type    = string
}
variable "instance_count" {
  description = "number of ec2 instance to create"
  type = number
  default =1
  
  
}