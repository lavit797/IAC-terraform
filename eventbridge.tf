# COST OPTIMIZATION BY TRIGGERING LAMDA FUNCTION USING EVENT DRIVEN SCHEDULE(CLOUD WATCH)

resource "aws_cloudwatch_event_rule" "snapshot_cleanup_rule" {
  name = "snapshot-cleanup-rule"
  description = "runs lambda every 5 min to delete stale snapshot"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.snapshot_cleanup_rule.name
  arn = aws_lambda_function.snapshot_cleanup.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id = "AllowExecutionFromEventBridge"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.snapshot_cleanup.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.snapshot_cleanup_rule.arn
}