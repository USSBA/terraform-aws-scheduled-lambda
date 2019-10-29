output "lambda_function" {
  value = var.enabled ? aws_lambda_function.function[0] : null
}
output "event_rule" {
  value = var.enabled ? aws_cloudwatch_event_rule.rule[0] : null
}
