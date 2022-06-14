provider "aws" {
  region                   = local.region
  shared_credentials_files = ["~/.aws/credentials"]
}

locals {
  region = "us-east-1"
  az = "us-east-1a"
  ami    = "ami-0c4f7023847b90238"
  tags = {
    Owner       = "abz"
    Environment = "test"
  }
}

resource "aws_vpc" "tf_ga_test_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = local.tags
}

resource "aws_subnet" "tf_ga_test_subnet" {
  vpc_id            = aws_vpc.tf_ga_test_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = local.az

  tags = local.tags
}

# resource "aws_security_group" "tf_ga_test_sg" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {`
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_tls"
#   }
# }


resource "aws_instance" "test_webserver" {
  ami           = local.ami
  instance_type = "t2.micro"

  tags = local.tags
}