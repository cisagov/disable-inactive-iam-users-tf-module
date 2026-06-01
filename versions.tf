terraform {
  # If you use any other providers you should also pin them to the
  # major version currently being used.  This practice will help us
  # avoid unwelcome surprises.
  required_providers {
    # Version 6.21 of the Terraform AWS provider was the first version
    # to support the Python 3.14 Lambda runtime:
    # https://github.com/hashicorp/terraform-provider-aws/blob/7f9e6a4e682ef80675b02f950f421e213a6067a0/CHANGELOG.md?plain=1#L1376
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.21"
    }
  }

  # Version 1.1 of Terraform is the first version to support the
  # nullable key in variable definitions.
  required_version = ">= 1.1"
}
