# variable "aws_region" {
#   description = "this is a variable for aws region"
#   type = string
#   default = "us-east-1"
# }

# variable "aws_instance" {
#   description = "type of aws instance"
#   type = string
#   default="t2.micro"
  
# }

# variable "instance_name" {
#   description = "EC2 Name"
#   type        = string
# }

variable "aws_region" {
  description = "region of aws"
  type = string
}
variable "vpc_cidr" {
  description = "ip range of virtual private cloud"
  type = string
}
variable "public_subnet_1" {
 type = string
}
variable "public_subnet_2" {
 type = string
}
variable "private_subnet_1" {
 type = string
}
variable "private_subnet_2" {
 type = string
}

variable "instance_type" {
  type = string
  
}



variable "desired_capacity" {
  type =number
}

variable "max_capacity" {
  type = number
}

variable "min_capacity" {
  type = number
}

variable "bastion_instance_type" {
  type = string
}