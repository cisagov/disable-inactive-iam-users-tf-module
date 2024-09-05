output "cloudwatch_event_rule" {
  value       = aws_cloudwatch_event_rule.lambda_schedule
  description = "The CloudWatch event rule that kicks off the Lambda function at a regular cadence."
}

output "cloudwatch_log_group" {
  value       = aws_cloudwatch_log_group.lambda_logs
  description = "The CloudWatch log group where the Lambda functions's logs are written."
}

output "lambda_function" {
  value       = aws_lambda_function.disable_inactive_iam_users
  description = "The Lambda function that disables inactive IAM users."
}

output "lambda_role" {
  value       = aws_iam_role.lambdaexecution_role
  description = "The IAM role used by the Lambda function."
}
