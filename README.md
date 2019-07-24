# terraform-aws-scheduled-lambda
A simple module to package and deploy lambda functions and have them trigger them on a schedule.

## Usage

### Variables

#### Required
* `source_directory` - Path to your lambda source directory, either absolute or relative to where you run `terraform apply`.  _Everything_ in this directory will be packaged and deployed into your lambda.
* `name`  - Used for lambda function name, role prefix, etc
* `lambda_iam_policy` - Lambda Parameter - IAM Policy, json-encoded
* `lambda_runtime` - Lambda Parameter - Runtime.  E.x. python3.6
* `lambda_handler` - Lambda Parameter - Handler reference, e.x. index.lambda_handler


#### Optional
* `schedule_expression` - Default: `rate(1 day)`; AWS Schedule Expression: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
* `lambda_variables` - Default: empty; Environment variables to pass to Lambda Function
* `lambda_timeout` - Default: 3; Number of seconds for the lambda to execute before the process is killed
* `lambda_layers` - Lambda Parameter - Used for custom runtime layers: https://docs.aws.amazon.com/lambda/latest/dg/runtimes-custom.html
* `enabled` - Default `true`; An optional way to disable the entire module.  This works around terraform being unable to `count = 0` for a module, and is helpful for turning off a modules resources per terraform workspace

### Example
```
module "my-bash-cron" {
  source = "ussba/terraform-aws-scheduled-lambda"
  name = "${terraform.workspace}-my-bash"
  source_directory = "./lambdas/my-bash-script"
  schedule_expression = "rate(10 minutes)"
  lambda_timeout = 30 #seconds
  lambda_runtime = "provided"
  lambda_layers = ["arn:aws:lambda:${module.global.region}:744348701589:layer:bash:8"]
  lambda_handler = "index.handler"
  lambda_variables = {
    ENVIRONMENT_WORKSPACE = terraform.workspace
  }
  lambda_iam_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid = "AllowSsmCommand"
          Effect = "Allow"
          Action = [
            "ssm:SendCommand",
            "ssm:GetCommandInvocation",
            "ssm:DescribeInstanceInformation",
          ]
          Resource = [
            "*"
          ]
        }
      ]
    }
  )
}
```

## Contributing

We welcome contributions.
To contribute please read our [CONTRIBUTING](CONTRIBUTING.md) document.

<sub>All contributions are subject to the license and in no way imply compensation for contributions.</sub>


## Code of Conduct
We strive for a welcoming and inclusive environment for all SBA projects.

Please follow this guidelines in all interactions:

* Be Respectful: use welcoming and inclusive language.
* Assume best intentions: seek to understand other's opinions.

## Security Policy

Please do not submit an issue on GitHub for a security vulnerability.
Instead, contact the development team through [HQVulnerabilityManagement](mailto:HQVulnerabilityManagement@sba.gov).
Be sure to include **all** pertinent information.

<sub>The agency reserves the right to change this policy at any time.</sub>
