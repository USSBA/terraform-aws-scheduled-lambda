output "lambda_function_arn" {
  value = module.lambda_function.lambda_function_arn
}
output "event_rule" {
  value = aws_cloudwatch_event_rule.rule
}
