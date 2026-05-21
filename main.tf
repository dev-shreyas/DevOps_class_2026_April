resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    "Name" = "my_vpc_created_by_terraform"
  }

}

resource "aws_subnet" "my_pubsubnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.vpc_subnet
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "my_public_subnet"
  } 
}

resource "aws_subnet" "my_pvtsubnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "my_private_subnet"
  } 
}



resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    "Name" = "my_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    "Name" = "public_route_table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id = aws_subnet.my_pubsubnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "my_sg" {
  name   = "allow_ssh"
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    "Name" = "allow_ssh_http_https"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = aws_vpc.my_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_443" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = aws_vpc.my_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "my_first_ec2_webserver" {

  ami = var.ec2_ami
  instance_type = var.ec2_size
  subnet_id = aws_subnet.my_pubsubnet.id
  security_groups = [
    aws_security_group.my_sg.id
  ]

  tags = {
    "Name" = "my_first_vm_webserver_from-TF"
  }
}

resource "aws_instance" "my_first_ec2_DBserver" {

  ami = var.ec2_ami
  instance_type = var.ec2_size
  subnet_id = aws_subnet.my_pvtsubnet.id
  associate_public_ip_address = false
  security_groups = [
    aws_security_group.my_sg.id
  ]

  tags = {
    "Name" = "my_first_vm_DBserver_from-TF"
  }
}

# resource "aws_s3_bucket" "my_s3_bucket_demo" {
#   bucket = var.s3_bucket

#   tags = {
#     "Name" = "my_s3_bucket_demo"
#   }
# }

resource "aws_ecr_repository" "my_ecr_repo" {
  name = var.ecr_repo
  image_tag_mutability = "MUTABLE"

  tags = {
    "Name" = "my_ecr_repo_demo"
  }  
}


