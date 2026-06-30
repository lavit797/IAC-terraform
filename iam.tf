# COST OPTIMIZATION BY TRIGGERING LAMDA FUNCTION USING EVENT DRIVEN SCHEDULE(CLOUD WATCH)

# resource "aws_iam_role" "lambda_role" {
#   name = "lambda-snapshot-cleanup-role"
#   assume_role_policy = jsonencode(
#     {

#         Version = "2012-10-17"
#         Statement = [
#             {
#                 Effect = "Allow"
#                 Principal = {
#                     Service = "lambda.amazonaws.com"
#                 }
#                 Action = "sts:AssumeRole"
#             }
#         ]
#     }
#   )
# }


# resource "aws_iam_policy" "lambda_policy" {

#   name = "lambda-snapshot-cleanup-policy"

#   policy = jsonencode({
#     Version = "2012-10-17"

#     Statement = [
#       {
#         Effect = "Allow"

#         Action = [
#           "ec2:DescribeSnapshots",
#           "ec2:DescribeInstances",
#           "ec2:DescribeVolumes",
#           "ec2:DeleteSnapshot"
#         ]

#         Resource = "*"
#       },
#       {
#         Effect = "Allow"

#         Action = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ]

#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "lambda_attachment" {
#     role = aws_iam_role.lambda_role.name
#     policy_arn = aws_iam_policy.lambda_policy.arn
  
# }