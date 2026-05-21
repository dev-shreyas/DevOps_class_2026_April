terraform {
  backend "s3" {
    bucket = "tf-backend-aws-resources-65326532"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }
}
