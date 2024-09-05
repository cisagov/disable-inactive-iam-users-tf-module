provider "aws" {
  # Our primary provider uses our terraform role
  assume_role {
    role_arn     = var.tf_role_arn
    session_name = "terraform-example"
  }
  default_tags {
    tags = var.tags
  }
  region = var.aws_region
}

#-------------------------------------------------------------------------------
# Configure the example module.
#-------------------------------------------------------------------------------
module "disable_inactive_iam_users" {
  source = "../../"
  providers = {
    aws = aws
  }

  lambda_bucket_name = "the-lambdas"
  lambda_key         = "disable_inactive_iam_users.zip"
  tags               = var.tags
}
