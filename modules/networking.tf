resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenacy}"

  tags = {
    Name = "test"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "Main"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "subnet_id" {
  value = "${aws_subnet.main.id}"
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "ipv6_cidr_block" {
  value = aws_vpc.main.ipv6_cidr_block

}