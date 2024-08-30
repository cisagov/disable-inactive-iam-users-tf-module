# disable-inactive-iam-users-tf-module #

[![GitHub Build Status](https://github.com/cisagov/disable-inactive-iam-users-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/disable-inactive-iam-users-tf-module/actions)

This is a generic skeleton project that can be used to quickly get a
new [cisagov](https://github.com/cisagov) [Terraform
module](https://www.terraform.io/docs/modules/index.html) GitHub
repository started.  This skeleton project contains [licensing
information](LICENSE), as well as [pre-commit
hooks](https://pre-commit.com) and
[GitHub Actions](https://github.com/features/actions) configurations
appropriate for the major languages that we use.

See [here](https://www.terraform.io/docs/modules/index.html) for more
details on Terraform modules and the standard module structure.

## Usage ##

```hcl
module "example" {
  source = "github.com/cisagov/disable-inactive-iam-users-tf-module"

  aws_region            = "us-west-1"
  aws_availability_zone = "b"
  subnet_id             = "subnet-0123456789abcdef0"
}
```

## Examples ##

- [Basic usage](https://github.com/cisagov/disable-inactive-iam-users-tf-module/tree/develop/examples/basic_usage)

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 4.9 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 4.9 |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.lambda_schedule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda_schedule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambdaexecution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambdaexecution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambdaexecution_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.disable_inactive_iam_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.lambda_assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambdaexecution_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| expiration\_days | A strictly positive integer denoting the number of days after which an IAM user's access is considered inactive if unused. | `number` | `45` | no |
| lambda\_function\_description | The description of the Lambda function. | `string` | `"Lambda function to disable inactive IAM users."` | no |
| lambda\_function\_name | The name of the Lambda function that will disable inactive IAM users. | `string` | `"disable-inactive-iam-users"` | no |
| lambda\_schedule\_interval | A string representing a rate expression defining the cadence at which the Lambda function is to be run.  See [the relevant AWS documentation](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-scheduled-rule-pattern.html#eb-rate-expressions) for more details. | `string` | `"1 day"` | no |
| lambda\_zip\_filename | The name of the ZIP file containing the Lambda function deployment package to disable inactive IAM users.  The file must be located in the root directory of this project. | `string` | `"lambda_build.zip"` | no |
| lambdaexecution\_role\_description | The description to associate with the IAM role (and policy) that allows the disable-inactive-iam-users Lambda to list users, see when they last accessed the console or used their access keys, and if necessary disable the console access or access key. | `string` | `"Allows the disable-inactive-iam-users Lambda to list users, see when they last accessed the console or used their access keys, and if necessary disable the console access or access key."` | no |
| lambdaexecution\_role\_name | The name to assign the IAM role (and policy) that allows the disable-inactive-iam-users Lambda to list users, see when they last accessed the console or used their access keys, and if necessary disable the console access or access key. | `string` | `"DisableInactiveIamUsersLambda"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| cloudwatch\_event\_rule | The CloudWatch event rule that kicks off the Lambda function at a regular cadence. |
| cloudwatch\_log\_group | The CloudWatch log group where the Lambda functions's logs are written. |
| lambda\_function | The Lambda function that disables inactive IAM users. |
| lambda\_role | The IAM role used by the Lambda function. |
<!-- END_TF_DOCS -->

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, these are the main directory and
every directory under `examples/`.

## New Repositories from a Skeleton ##

Please see our [Project Setup guide](https://github.com/cisagov/development-guide/tree/develop/project_setup)
for step-by-step instructions on how to start a new repository from
a skeleton. This will save you time and effort when configuring a
new repository!

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
