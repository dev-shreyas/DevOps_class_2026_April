output "aws_vpc" {
  value = aws_vpc.my_vpc.id
}

output "aws_ec2_webserver" {
  value = aws_instance.my_first_ec2_webserver.id
}

output "aws_ec2_DBserver" {
  value = aws_instance.my_first_ec2_DBserver.id
}

output "aws_s3" {
  value = aws_s3_bucket.my_s3_bucket_demo.bucket
}

output "aws_ecr" {
  value = aws_ecr_repository.my_ecr_repo.repository_url
}

