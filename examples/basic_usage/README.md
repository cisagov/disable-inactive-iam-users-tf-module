# Basic Usage #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 4.9 |

## Providers ##

No providers.

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| disable\_inactive\_iam\_users | ../../ | n/a |

## Resources ##

No resources.

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tags | Tags to apply to all AWS resources created. | `map(string)` | ```{ "Testing": true }``` | no |
| tf\_role\_arn | The ARN of the role that can terraform non-specialized resources. | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| disable\_inactive\_iam\_users | The outputs of the cisagov/disable-inactive-iam-users-tf-module module. |
<!-- END_TF_DOCS -->
