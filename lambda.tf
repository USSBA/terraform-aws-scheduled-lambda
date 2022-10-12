module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.0"

  function_name = var.name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  layers        = var.lambda_layers

  publish = true

  #create_package         = false
  #local_existing_package = "${path.module}/../fixtures/python3.8-zip/existing_package.zip"
  source_path = var.source_directory

  allowed_triggers = {
    ScanAmiRule = {
      principal  = "events.amazonaws.com"
      source_arn = aws_cloudwatch_event_rule.rule.arn
    }
  }
  timeout               = var.lambda_timeout
  tags                  = merge(var.tags, var.tags_lambda)
  environment_variables = var.lambda_variables

  attach_policy_json = true
  policy_json        = var.lambda_iam_policy
  artifacts_dir      = var.builds_dir
}

resource "aws_cloudwatch_event_rule" "rule" {
  name                = var.name
  schedule_expression = var.schedule_expression
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "target" {
  rule = aws_cloudwatch_event_rule.rule.name
  arn  = module.lambda_function.lambda_function_arn
}

output "lambda_module" {
  value = module.lambda_function
}
