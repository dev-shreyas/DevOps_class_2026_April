variable "aws_region" {
  type = string
  description = "This is to define value of aws region"
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type = string
  description = "The vpc cidr range"
  default = "10.0.0.0/16"
}

variable "vpc_subnet" {
  type = string
  description = "The vpc subnet cidr range"
  default = "10.0.1.0/24"
}

variable "ec2_ami" {
  type = string
  description = "Pass AMI ID"
  default = "ami-009be0edec0817ffd"
}

variable "ec2_size" {
  type = string
  description = "Provide a size of ec2 instance"
  default = "t3.xlarge"
}

variable "s3_bucket" {
  type = string
  description = "Provide name to s3"
  default = "my-s3-demo-bucket-85426357"
}

variable "ecr_repo" {
  type = string
  description = "Provide ecr name"
  default = "my_ecr_repo_demo"
}