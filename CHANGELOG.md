# Changelog

## v4.0.0

This module has swapped to use the well-supported, semi-official "terraform-aws-lambda" module, so all resources will be recreated.

With the change, there's not much need for this module to exist anymore. It requires a mere 2 additional resources to create the lambda on a schedule on top of the other public module. For consistency sake, we will keep this module around, but will likely update it less frequently

* **BREAKING CHANGES**:
  * Output no longer sends the whole lambda function
  * All resources will be recreated
  * The lambda log-group will need to be imported, as it previously was created by the running lambda at execution time, but now it's created explicitly by the module
  * The zip built will now be dropped in a "builds" directory in the directory wherever the terraform is run.  This can be overridden with the "builds_dir" variable

* **UPGRADE GUIDE**:
  * `terraform import module.YOUR_TFMODULE_NAME.module.lambda_function.aws_cloudwatch_log_group.lambda[0] /aws/lambda/NAME_VARIABLE_PASSED_INTO_MODULE`

## v3.0.0

* change: Added configurable retry attempts variable to control what happens when an invocation error occurs

## v2.1.0

* change: Adding tag variables
* bugfix: Fixing bug when no environment variables passed in

## v2.0.1

* Updated documentation for clarity and ease of use, added code validation to CircleCI config, pre-commit config, and updated license

## v2.0.0

* Support for Terraform version 0.13
* Removed variable `enabled`

## v1.0.2

* change: Move zipped package to `var.source_directory/..` to de-clutter the base directory
* bugfix: Add null response to outputs if module is disabled

## v1.0.1

* bugfix: Move zipped package to `path.root` for function state consistency

## v1.0.0

* Initial Release
