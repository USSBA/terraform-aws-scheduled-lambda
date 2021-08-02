data "aws_iam_policy_document" "lambdaAssumeRole" {
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}
resource "aws_iam_role" "lambdaRole" {
  name_prefix        = var.name
  assume_role_policy = data.aws_iam_policy_document.lambdaAssumeRole.json
  description        = "A Lambda execution role for the ${var.name} function"
  tags               = var.tags
}
resource "aws_iam_role_policy" "lambdaRolePolicy" {
  name_prefix = var.name
  policy      = var.lambda_iam_policy
  role        = aws_iam_role.lambdaRole.id
}
resource "aws_iam_role_policy_attachment" "lambdaRoleAttachment1" {
  role       = aws_iam_role.lambdaRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
resource "aws_lambda_function" "function" {
  filename         = data.archive_file.package.output_path
  function_name    = var.name
  role             = aws_iam_role.lambdaRole.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  layers           = var.lambda_layers
  source_code_hash = data.archive_file.package.output_base64sha256
  timeout          = var.lambda_timeout
  dynamic "environment" {
    for_each = length(keys(var.lambda_variables)) > 0 ? ["Only create when not empty"] : []
    content {
      variables = var.lambda_variables
    }
  }
  depends_on = [data.archive_file.package]

  tags = merge(var.tags, var.tags_lambda)
}
resource "aws_lambda_function_event_invoke_config" "invoke_config" {
  function_name                = aws_lambda_function.function.function_name
  maximum_event_age_in_seconds = 21600
  maximum_retry_attempts       = var.maximum_retry_attempts
}
