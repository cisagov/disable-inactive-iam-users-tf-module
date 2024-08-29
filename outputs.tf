output "lambda" {
  value       = aws_lambda_function.disable_inactive_iam_users
  description = "The Lambda function that disables inactive IAM users."
}
