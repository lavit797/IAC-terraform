# COST OPTIMIZATION BY TRIGGERING LAMDA FUNCTION USING EVENT DRIVEN SCHEDULE(CLOUD WATCH)

data "archive_file" "lambda_zip" {
  type = "zip"
  source_file = "${path.module}/lambda/lambda_function.py"
  output_path = "${path.module}/lambda/lambda.zip"
}

resource "aws_lambda_function" "snapshot_cleanup" {
  function_name = var.lambda_function_name
  role = aws_iam_role.lambda_role.arn
  runtime = "python3.13"
  handler = "lambda_function.lambda_handler"
  filename = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  timeout = var.lambda_timeout

  memory_size = var.lambda_memory
}