# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "lambda_bucket_name" {
  description = "The name of the S3 bucket containing the Lambda function deployment package to disable inactive IAM users."
  nullable    = false
  type        = string
}

variable "lambda_key" {
  description = "The S3 key associated with the Lambda function deployment package to disable inactive IAM users."
  nullable    = false
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region to deploy into (e.g. us-east-1)."
  nullable    = false
  type        = string
}

variable "expiration_days" {
  default     = 45
  description = "A strictly positive integer denoting the number of days after which an IAM user's access is considered inactive if unused."
  nullable    = false
  type        = number

  validation {
    condition     = alltrue([floor(var.expiration_days) == var.expiration_days, var.expiration_days > 0])
    error_message = "expiration_days must be a positive integer greater than zero."
  }
}

variable "lambda_function_description" {
  default     = "Lambda function to disable inactive IAM users."
  description = "The description of the Lambda function that will disable inactive IAM users."
  nullable    = false
  type        = string
}

variable "lambda_function_name" {
  default     = "disable-inactive-iam-users"
  description = "The name of the Lambda function that will disable inactive IAM users."
  nullable    = false
  type        = string
}

variable "lambda_schedule_interval" {
  default     = "1 day"
  description = "A string representing a rate expression defining the cadence at which the Lambda function is to be run.  See [the relevant AWS documentation](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-scheduled-rule-pattern.html#eb-rate-expressions) for more details."
  nullable    = false
  type        = string
}

variable "lambdaexecution_role_description" {
  default     = "Allows the disable-inactive-iam-users Lambda to list users, see when they last accessed the console or used their access keys, and if necessary disable the console access or access key."
  description = "The description to associate with the IAM role (and policy) that allows the disable-inactive-iam-users Lambda to list users, see when they last accessed the console or used their access keys, and if necessary disable the console access or access key."
  nullable    = false
  type        = string
}

variable "lambdaexecution_role_name" {
  default     = "DisableInactiveIamUsersLambda"
  description = "The name to assign the IAM role (and policy) that allows the disable-inactive-iam-users Lambda to list users, see when they last accessed the console or used their access keys, and if necessary disable the console access or access key."
  nullable    = false
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  nullable    = false
  type        = map(string)
}
