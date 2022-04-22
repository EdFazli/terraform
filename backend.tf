data "aws_ssm_parameter" "aws_credentials" {
  name = "/terraform/aws/credentials"
}

####################
# Define Terraform #
####################
terraform {
    required_version = ">=1.1"
    backend "s3" {
        bucket = "fazli-terraform-statefile"
        key    = "tf/terraform.tfstate"
        region = "ap-southeast-1"
        encrypt = true
        dynamodb_table = "fazli-terraform-statefile-lock"
        shared_credentials_file = data.aws_ssm_parameter.aws_credentials.value
  }
}