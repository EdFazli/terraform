# data "aws_ssm_parameter" "aws_credentials" {
#   name = "/terraform/aws/credentials"
# }

#######################
# Provider Definition #
#######################
provider "aws" {
  region = var.region
  shared_credentials_file = data.aws_ssm_parameter.aws_credentials.value
}