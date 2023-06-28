# DISCLAIMER

**THE USSBA WILL BE DEPRECATING THIS MODULE IN THE NEXT 6 MONTHS AND WILL NO LONGER BE MAKING UPDATES TO THIS MODULE.**

# terraform-aws-scheduled-lambda

A simple module to package and deploy lambda functions and have them trigger them on a schedule.

## Usage

### Variables

#### Required

* `source_directory` - Path to your Lambda source directory, either absolute or relative to where you run `terraform apply`.  _Everything_ in this directory will be packaged and deployed into your lambda.
* `name`  - Used for lambda function name, role prefix, etc
* `lambda_iam_policy` - IAM Policy for the lambda, json-encoded
* `lambda_runtime` - The [runtime](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html) (or language) the Lambda uses, e.g. python3.8
* `lambda_handler` - The Lambda handler (the function used in your code), e.g. index.lambda_handler

#### Optional

* `schedule_expression` - Default: `rate(1 day)`; [AWS Schedule Expression](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html)
* `lambda_variables` - Default: `{}`; Environment variables to pass to Lambda Function
* `lambda_timeout` - Default: 3; Number of seconds for the lambda to execute before the process is killed
* `lambda_layers` - Default: `[]`; Only required if `lambda_runtime` is set to `provided` or `provided.al2`. See [custom runtime layers](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-custom.html) for more info
* `tags` - Default: `{}`; Add these tags to all tagable resources
* `tags_lambda` - Default: `{}`; Add these tags to the lambda function

### Example

Example of a node lambda:

```terraform
data "aws_iam_policy_document" "my_lambda_policy" {
  # IAM policy document defined here
}

module "my-node-lambda" {
  source            = "USSBA/scheduled-lambda/aws"
  version           = "~> 2.0"
  name              = "my-node-lambda"
  source_directory  = "./lambdas/my-node-script"
  lambda_runtime    = "nodejs12.x"
  lambda_handler    = "index.handler"
  lambda_iam_policy = data.aws_iam_policy_document.my_lambda_policy
}
```

Example of bash lambda:

```terraform
data "aws_iam_policy_document" "my_lambda_policy" {
  # IAM policy document defined here
}

module "my-bash-lambda" {
  source            = "USSBA/scheduled-lambda/aws"
  version           = "~> 2.0"
  name              = "my-bash-lambda"
  source_directory  = "./lambdas/my-bash-script"
  lambda_runtime    = "provided"
  lambda_layers     = ["arn:aws:lambda:us-east-1:744348701589:layer:bash:8"]
  lambda_handler    = "index.handler"
  lambda_iam_policy = data.aws_iam_policy_document.my_lambda_policy
  lambda_variables = {
    ENVIRONMENT = "prod"
  }
}
```

## Contributing

We welcome contributions.
To contribute please read our [CONTRIBUTING](CONTRIBUTING.md) document.

All contributions are subject to the license and in no way imply compensation for contributions.

### Terraform 0.12

Our code base now exists in Terraform 0.13 and we are halting new features in the Terraform 0.12 major version.  If you wish to make a PR or merge upstream changes back into 0.12, please submit a PR to the `terraform-0.12` branch.

## Code of Conduct

We strive for a welcoming and inclusive environment for all SBA projects.

Please follow this guidelines in all interactions:

* Be Respectful: use welcoming and inclusive language.
* Assume best intentions: seek to understand other's opinions.

## Security Policy

Please do not submit an issue on GitHub for a security vulnerability.
Instead, contact the development team through [HQVulnerabilityManagement](mailto:HQVulnerabilityManagement@sba.gov).
Be sure to include **all** pertinent information.
