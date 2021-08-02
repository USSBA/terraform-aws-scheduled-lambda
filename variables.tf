variable "name" {
  type        = string
  description = "Used for lambda function name, role prefix, etc"
}
variable "source_directory" {
  type = string
}
variable "schedule_expression" {
  type        = string
  description = "AWS Schedule Expression: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  default     = "rate(1 day)"
}
variable "lambda_iam_policy" {
  type        = string
  description = "Lambda Parameter - IAM Policy, json-encoded"
}
variable "lambda_variables" {
  type        = map(any)
  default     = {}
  description = "Lambda Parameter - Environment Variables sent to function"
}
variable "lambda_timeout" {
  type        = number
  default     = 3
  description = "Lambda Parameter - Timeout (seconds)"
}
variable "lambda_runtime" {
  type        = string
  description = "Lambda Parameter - Runtime.  E.x. python3.6"
}
variable "lambda_layers" {
  type        = list(any)
  default     = []
  description = "Lambda Parameter - Used for custom runtime layers"
}
variable "lambda_handler" {
  type        = string
  description = "Lambda Parameter - Handler reference, e.x. index.lambda_handler"
}
variable "maximum_retry_attempts" {
  type        = number
  description = "Maximum number of retry attempts if an error occurs during invocation.  Default is 0."
  default     = 0
}

variable "tags" {
  type        = map(any)
  description = "Tags to be applied to any resource that accepts tags.  Default is {}"
  default     = {}
}
variable "tags_lambda" {
  type        = map(any)
  description = "Tags to be applied only to the lambda function.  Default is {}"
  default     = {}
}
