####################
# define terraform #
####################
terraform {
    required_version = ">=1.1"
    backend "s3" {
        bucket = "fazli-terraform-statefile"
        key    = "tf/terraform.tfstate"
        region = "ap-southeast-1"
        encrypt = true
        dynamodb_table = "fazli-terraform-statefile"
  }
}