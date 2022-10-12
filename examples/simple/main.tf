data "aws_iam_policy_document" "lambda_permissions" {
  statement {
    sid = "Buckets"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}
module "my_node_lambda" {
  source = "../.."
  #source            = "USSBA/scheduled-lambda/aws"
  #version           = "~> 2.1"

  name                = "scheduled-lambda-example-simple"
  source_directory    = "./script_src/"
  lambda_runtime      = "nodejs12.x"
  lambda_handler      = "index.handler"
  schedule_expression = "rate(2 minutes)"
  lambda_iam_policy   = data.aws_iam_policy_document.lambda_permissions.json
  tags = {
    foo = "bar"
  }
  tags_lambda = {
    function = "lambda"
  }
}

provider "aws" {
  region = "us-east-1"
}
