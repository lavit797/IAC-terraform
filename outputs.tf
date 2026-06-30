# CREATED AN EC2 INSTANCE AND ATTACHED A SNAPSHOT WITH IT

# output "instance_id" {
#     value = aws_instance.server.id
#   }
# output "public_ip" {
#     value = aws_instance.server.public_ip
#   }
# output "volume_id" {
#     value = data.aws_ebs_volume.root-ebs-volume.id
#   }

#   output "snapshot_id" {
#     value = aws_ebs_snapshot.aws-snapshot.id
#      }

#      output "instance_name" {
#         value = var.instance_name
       
#      }


# PRODUCTION LEVEL VPC ARCHITECTURE

# output "aws_availability_zone" {
#   value = data.aws_availability_zones.available
# }

# output "vpc_id" {
#     value = aws_vpc.main.id
  
# }

# output "elastic_ip" {

#   value = aws_eip.nat_eip.public_ip

# }

# output "nat_gateway_id" {

#   value = aws_nat_gateway.nat.id

# }

# output "public_route_table_id" {

#   value = aws_route_table.public_rt.id

# }

# output "private_route_table_id" {

#   value = aws_route_table.private_rt.id

# }

# output "bastion_sg" {

#   value = aws_security_group.bastion_sg.id

# }

# output "alb_sg" {

#   value = aws_security_group.alb_sg.id

# }

# output "application_sg" {

#   value = aws_security_group.application_sg.id

# }

# output "launch_template_id" {

#   value = aws_launch_template.app-lt.id

# }

# output "autoscaling_group" {

#   value = aws_autoscaling_group.app-asg.name

# }

# output "bastion_public_ip" {

#   value = aws_instance.bastion.public_ip

# }

# output "alb_dns_name" {
#   value = aws_lb.app_alb.dns_name
# }

# output "alb_arn" {
#   value = aws_lb.app_alb.arn
# }

# output "target_group_arn" {
#   value = aws_lb_target_group.app-tg.arn
# }

# COST OPTIMIZATION BY TRIGGERING LAMDA FUNCTION USING EVENT DRIVEN SCHEDULE(CLOUD WATCH)

output "lambda_function_name" {
  description = "Lambda Function Name"

  value = aws_lambda_function.snapshot_cleanup.function_name
}

output "lambda_function_arn" {
  description = "Lambda ARN"

  value = aws_lambda_function.snapshot_cleanup.arn
}

output "eventbridge_rule_name" {
  description = "EventBridge Rule"

  value = aws_cloudwatch_event_rule.snapshot_cleanup_rule.name
}

output "iam_role_name" {
  description = "IAM Role"

  value = aws_iam_role.lambda_role.name
}

output "iam_policy_name" {
  description = "IAM Policy"

  value = aws_iam_policy.lambda_policy.name
}
