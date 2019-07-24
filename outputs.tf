output "lambda_function" {
  value = aws_lambda_function.function[0]
}
output "event_rule" {
  value = aws_cloudwatch_event_rule.rule[0]
}
