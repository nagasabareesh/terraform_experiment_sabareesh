variable "ec2_count" {
  default = 2
}

variable "ami_id" {
  default = "ami-03f4c416f489586a3"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {}
