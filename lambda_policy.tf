# ------------------------------------------------------------------------------
# Create the IAM policy that allows the disable-inactive-iam-users
# Lambda to access all resources needed to do its job.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "lambdaexecution_doc" {
  statement {
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = [
      format("arn:aws:logs:%s:%s:*", var.aws_region, data.aws_caller_identity.this.account_id)
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      format("arn:aws:logs:%s:%s:log-group:/aws/lambda/%s:*",
      var.aws_region, data.aws_caller_identity.this.account_id, var.lambda_function_name)
    ]
  }

  statement {
    actions = [
      "iam:DeleteLoginProfile",
      "iam:GetAccessKeyLastUsed",
      "iam:GetLoginProfile",
      "iam:ListAccessKeys",
      "iam:ListUsers",
      "iam:UpdateAccessKey",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambdaexecution_policy" {
  description = var.lambdaexecution_role_description
  name        = var.lambdaexecution_role_name
  policy      = data.aws_iam_policy_document.lambdaexecution_doc.json
}
