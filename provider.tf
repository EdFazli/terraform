data "aws_ssm_parameter" "aws_credentials" {
  name = "/terraform/aws/credentials"
}

###################
# Define Provider #
###################
provider "aws" {
  region = var.region
  shared_credentials_file = data.aws_ssm_parameter.aws_credentials.value
}