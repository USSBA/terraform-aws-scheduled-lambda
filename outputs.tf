output "lambda_function" {
  value = aws_lambda_function.function
}
output "event_rule" {
  value = aws_cloudwatch_event_rule.rule
}
