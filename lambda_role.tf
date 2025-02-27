# ------------------------------------------------------------------------------
# Create the IAM role that allows the disable-inactive-iam-users
# Lambda to access all resources needed to do its job.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "lambdaexecution_role" {
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_doc.json
  description        = var.lambdaexecution_role_description
  name               = var.lambdaexecution_role_name
}

resource "aws_iam_role_policy_attachment" "lambdaexecution_policy_attachment" {
  policy_arn = aws_iam_policy.lambdaexecution_policy.arn
  role       = aws_iam_role.lambdaexecution_role.name
}
