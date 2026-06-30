# CREATED AN EC2 INSTANCE AND ATTACHED A SNAPSHOT WITH IT

# data "aws_ami" "ubuntu-aws" {
#   most_recent = true
#   owners = ["099720109477"]

#   filter {
#     name = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }
# }

# resource "aws_security_group" "web_sg" {
#   name = "terraform-web-sg"
  
#   ingress {

#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"

#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {

#     from_port = 8080
#     to_port   = 8080
#     protocol  = "tcp"

#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress  {

#     from_port = 0
#     to_port   = 0
#     protocol  = "-1"

#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_instance" "server" {
#   ami = data.aws_ami.ubuntu-aws.id
#   instance_type = var.aws_instance
#   vpc_security_group_ids = [
#     aws_security_group.web_sg.id
#   ]
#   tags = {
#     name = var.instance_name
#   }
# }

# data "aws_ebs_volume" "root-ebs-volume" {
#   filter {
#     name = "attachment.instance-id"
#     values = [
#       aws_instance.server.id]
#   }

#   depends_on = [ 
#     aws_instance.server
#    ]
# }

# resource "aws_ebs_snapshot" "aws-snapshot" {
#   volume_id = data.aws_ebs_volume.root-ebs-volume.id

#   tags = {
#     name = "terraform-snapshot"
#   }
# }

# PRODUCTION LEVEL VPC ARCHITECTURE

# resource "aws_vpc" "main" {
#     cidr_block = var.vpc_cidr
#     enable_dns_support = true
#     enable_dns_hostnames = true
#     tags = {
#       Name="production vpc"
#     }
#   }

#   resource "aws_internet_gateway" "igw" {

#     vpc_id = aws_vpc.main.id

#     tags ={
#         Name="production-IGW"
#     }
    
#   }

#   data "aws_availability_zones" "available" {
#     state="available"
#   }

#   resource "aws_subnet" "public_subnet_1" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = var.public_subnet_1
#     availability_zone = data.aws_availability_zones.available.names[0]
#     map_public_ip_on_launch = true
#     tags = {
#         Name="public_subnet_1"
#     }
#   }

#   resource "aws_subnet" "public_subnet_2" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = var.public_subnet_2
#     availability_zone = data.aws_availability_zones.available.names[1]
#     map_public_ip_on_launch = true
#     tags = {
#         Name="public_subnet_2"
#     }
#   }

#   resource "aws_subnet" "private_subnet_1" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = var.private_subnet_1
#     availability_zone = data.aws_availability_zones.available.names[0]
#     map_public_ip_on_launch = false
#     tags = {
#         Name="private_subnet_1"
#     }
#   }

#    resource "aws_subnet" "private_subnet_2" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = var.private_subnet_2
#     availability_zone = data.aws_availability_zones.available.names[1]
#     map_public_ip_on_launch = false
#     tags = {
#         Name="private_subnet_2"
#     }
#   }

#   resource "aws_eip" "nat_eip" {
#     domain = "vpc"
#     tags ={
#       Name="production-NAT-EIP"
#     }
#   }

#  resource "aws_nat_gateway" "nat" {
#    allocation_id = aws_eip.nat_eip.id
#    subnet_id = aws_subnet.public_subnet_1.id

#    depends_on = [ 
#     aws_internet_gateway.igw
#     ]

#     tags = {
#       Name="production NAT"
#     }
#  }

#  resource "aws_route_table" "public_rt" {
   
# vpc_id = aws_vpc.main.id
# route  {
#   cidr_block="0.0.0.0/0"
#   gateway_id = aws_internet_gateway.igw.id
# }
# tags = {
#   Name = "public-route-table"
# }

#  }

# resource "aws_route_table" "private_rt" {

#   vpc_id = aws_vpc.main.id
#   route  {
# cidr_block = "0.0.0.0/0"
# nat_gateway_id= aws_nat_gateway.nat.id
#  }

#   tags = {

#     Name = "Private-Route-Table"

#   }
  
# }

# resource "aws_route_table_association" "public_subnet_1" {
#  subnet_id = aws_subnet.public_subnet_1.id
#  route_table_id = aws_route_table.public_rt.id
# }

# resource "aws_route_table_association" "public_subnet_2" {
  
# subnet_id = aws_subnet.public_subnet_2.id
# route_table_id = aws_route_table.public_rt.id
# }

# resource "aws_route_table_association" "private_subnet_1" {
#   subnet_id = aws_subnet.private_subnet_1.id
#   route_table_id = aws_route_table.private_rt.id
# }

# resource "aws_route_table_association" "private_subnet_2" {
#   subnet_id = aws_subnet.private_subnet_2.id
#   route_table_id = aws_route_table.private_rt.id
# }

# resource "aws_security_group" "bastion_sg" {
# name = "bastion-sg"
# description = "Bastion Security Group"
#   vpc_id = aws_vpc.main.id

#   ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["157.119.82.214/32"]
#   }

#   egress {

#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name= "bastion-SG"
#   }
# }

# resource "aws_security_group" "alb_sg" {

#   name = "alb-sg"

#   vpc_id = aws_vpc.main.id

#   ingress {

#     from_port = 80

#     to_port = 80

#     protocol = "tcp"

#     cidr_blocks = ["0.0.0.0/0"]

#   }

#   ingress {

#     from_port = 443

#     to_port = 443

#     protocol = "tcp"

#     cidr_blocks = ["0.0.0.0/0"]

#   }

#   egress {

#     from_port = 0

#     to_port = 0

#     protocol = "-1"

#     cidr_blocks = ["0.0.0.0/0"]

#   }
# }

# resource "aws_security_group" "application_sg" {
# name = "application-sg"
# vpc_id = aws_vpc.main.id

# ingress {
#  from_port = 8080
#  to_port = 8080
#  protocol = "tcp"
#  security_groups = [
#   aws_security_group.alb_sg.id
#  ]

# }

# ingress {

#     from_port = 22

#     to_port = 22

#     protocol = "tcp"

#     security_groups = [

#       aws_security_group.bastion_sg.id

#     ]
# }
  
#  egress {

#     from_port = 0

#     to_port = 0

#     protocol = "-1"

#     cidr_blocks = [

#       "0.0.0.0/0"

#     ]

#   }


# }

# data "aws_key_pair" "existing_key" {
#   key_name = "aws-ec2"
# }

# data "aws_ami" "ubuntu-aws" {
#   most_recent = true
#   owners = ["099720109477"]

#   filter {
#     name = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }
# }


# resource "aws_iam_role" "ec2_role" {
#   name = "production-ec2-role"

#   assume_role_policy = jsonencode({
# Version = "2012-10-17"
# Statement = [
# {
#   Effect = "allow"

#   Principal = {
#       Service = "ec2.amazonaws.com"
#   }

#       Action = "sts:AssumeRole"
# }
# ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ssm" {
#   role = aws_iam_role.ec2_role.name
# policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

# } 

# resource "aws_iam_instance_profile" "profile" {
#   name = "production-profile"
#   role = aws_iam_role.ec2_role.name
# }

# resource "aws_launch_template" "app-lt" {

#   name_prefix = "production-lt"
#   image_id = data.aws_ami.ubuntu-aws.id
#   instance_type = var.instance_type
#   key_name = data.aws_key_pair.existing_key.key_name

#   vpc_security_group_ids = [
#     aws_security_group.application_sg.id
#   ]
  
#   iam_instance_profile {
#     name = aws_iam_instance_profile.profile.name
#   }

#   block_device_mappings {
#      device_name = "/dev/xvda"
# ebs {
#   volume_size = 20
#   volume_type = "gp3"
#   encrypted = true
# }

#   }

#   tag_specifications {
#     resource_type = "instance"

#     tags = {
#       Name = "application-server"
#     }
#   }
# }

# resource "aws_autoscaling_group" "app-asg" {
# desired_capacity = var.desired_capacity
# min_size = var.min_capacity
# max_size = var.max_capacity

# vpc_zone_identifier = [ 
# aws_subnet.private_subnet_1.id,
# aws_subnet.private_subnet_2.id

#  ]

#  launch_template {
#    id = aws_launch_template.app-lt.id 
#    version = "$Latest"
#  }
# health_check_type = "EC2"

#   force_delete = true
# tag {

#     key = "Name"

#     value = "Production-ASG"

#     propagate_at_launch = true

#   }
  

# }

# resource "aws_instance" "bastion" {
  
# ami = data.aws_ami.ubuntu-aws.id
# instance_type = var.bastion_instance_type
# subnet_id = aws_subnet.public_subnet_1.id
# vpc_security_group_ids = [
#   aws_security_group.bastion_sg.id
# ]
#  associate_public_ip_address = true
#  key_name = data.aws_key_pair.existing_key.key_name

#    tags = {

#     Name = "Bastion-Host"

#   }
# }


# resource "aws_lb" "app_alb" {
#   name = "production-lb"
#   internal = false
#   load_balancer_type = "application"

#   security_groups = [ 
#  aws_security_group.alb_sg.id
#   ]

#   subnets = [
#     aws_subnet.public_subnet_1.id,
#     aws_subnet.public_subnet_2.id
#   ]

#   enable_deletion_protection = false


#    tags = {
#     Name = "Production-ALB"
#   }
# }

# resource "aws_lb_target_group" "app-tg" {
# name ="production-target-group"

# port = 8080
# protocol = "HTTP"
# vpc_id = aws_vpc.main.id

# target_type = "instance"

# health_check {
#   enabled = true
#   path = "/"
#   protocol = "HTTP"
#   matcher = "200"
# }
# }

# resource "aws_alb_listener" "http" {

# load_balancer_arn = aws_lb.app_alb.arn
#   port = 80
#   protocol = "HTTP"
#   default_action {
#     type = "forward"

#     target_group_arn = aws_lb_target_group.app-tg.arn
#   }
  
# }

# resource "aws_autoscaling_attachment" "asg_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.app-asg.id
#   lb_target_group_arn = aws_lb_target_group.app-tg.arn
# }

