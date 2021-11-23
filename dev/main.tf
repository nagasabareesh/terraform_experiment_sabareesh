provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

module "my_vpc" {
  # source = "../modules/vpc"
  # source      = "github.com/nagasabareesh/simpleterraform?ref=main"
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenacy      = "default"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_cidr = "192.168.1.0/24"

}

module "my_ec2" {
  source    = "../modules/ec2"
  ec2_count = 2
  ami_id    = "ami-04902260ca3d33422"
  subnet_id = "${module.my_vpc.subnet_id}"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${module.my_vpc.vpc_id}"

  # ingress {
  #   description = "TLS from VPC"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   # cidr_blocks      = [aws_vpc.main.cidr_block]
  #   cidr_blocks      = [module.my_vpc.cidr_block]
  #   ipv6_cidr_blocks = [module.my_vpc.ipv6_cidr_block]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}