# ------------------------------------------------------------------------------
# The AWS Lambda function that is used to disable the access of
# inactive IAM users.  The ZIP file is created with:
# http://github.com/cisagov/disable-inactive-iam-users-lambda
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "disable_inactive_iam_users" {
  description      = var.lambda_function_description
  filename         = var.lambda_zip_filename
  function_name    = var.lambda_function_name
  handler          = "lambda_handler.handler"
  memory_size      = 128
  role             = aws_iam_role.lambdaexecution_role.arn
  runtime          = "python3.9"
  source_code_hash = filebase64sha256(var.lambda_zip_filename)
  timeout          = 900
}

# The CloudWatch log group for the Lambda function
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = format("/aws/lambda/%s", var.lambda_function_name)
  retention_in_days = 30
}

# Schedule the Lambda function to run at a regular cadence
resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  description         = format("Executes %s Lambda every %s.", var.lambda_function_name, var.lambda_schedule_interval)
  name                = format("%s-every-%s", var.lambda_function_name, replace(var.lambda_schedule_interval, " ", "-"))
  schedule_expression = format("rate(%s)", var.lambda_schedule_interval)
}

resource "aws_cloudwatch_event_target" "lambda_schedule" {
  arn = aws_lambda_function.disable_inactive_iam_users.arn
  input = jsonencode({
    expiration_days = var.expiration_days
    task            = "disable"
  })
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "lambda"
}

# Allow the CloudWatch event to invoke the Lambda function
resource "aws_lambda_permission" "allow_cloudwatch" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.disable_inactive_iam_users.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
  statement_id  = "AllowExecutionFromCloudWatch"
}
