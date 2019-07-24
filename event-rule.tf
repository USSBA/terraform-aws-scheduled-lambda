resource "aws_cloudwatch_event_rule" "rule" {
  count               = local.enabled_count
  name                = var.name
  schedule_expression = var.schedule_expression
}
resource "aws_cloudwatch_event_target" "target" {
  count = local.enabled_count
  rule  = aws_cloudwatch_event_rule.rule[0].name
  arn   = aws_lambda_function.function[0].arn
}
resource "aws_lambda_permission" "allow_cloudwatch" {
  count         = local.enabled_count
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule[0].arn
}
