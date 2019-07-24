data "aws_iam_policy_document" "lambdaAssumeRole" {
  count = local.enabled_count
  statement {
    sid = "1"
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
  count = local.enabled_count
  name_prefix = var.name
  assume_role_policy = data.aws_iam_policy_document.lambdaAssumeRole[0].json
  description = "A Lambda execution role for the ${var.name} function"
}
resource "aws_iam_role_policy" "lambdaRolePolicy" {
  count = local.enabled_count
  name_prefix = var.name
  policy = var.lambda_iam_policy
  role = aws_iam_role.lambdaRole[0].id
}
resource "aws_iam_role_policy_attachment" "lambdaRoleAttachment1" {
  count = local.enabled_count
  role = aws_iam_role.lambdaRole[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
resource "aws_lambda_function" "function" {
  count = local.enabled_count
  filename = data.archive_file.package[0].output_path
  function_name = var.name
  role = aws_iam_role.lambdaRole[0].arn
  handler = var.lambda_handler
  runtime = var.lambda_runtime
  layers = var.lambda_layers
  source_code_hash = data.archive_file.package[0].output_base64sha256
  timeout = var.lambda_timeout
  environment {
    variables = var.lambda_variables
  }
  depends_on = [ data.archive_file.package ]
}
