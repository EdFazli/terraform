###############################
# Backend Statefile Resources #
###############################

module "s3_statefile" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "fazli-terraform-statefile"
  acl    = "private"

  versioning = {
    enabled = true
  }

  tags = {
      Creator = "Fazli"
  }

}

module "dynamodb_tfstate_lock" {
    source = "./modules/dynamodb-table"

    name = "fazli-terraform-statefile-lock"
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"
    table_class = "STANDARD_INFREQUENT_ACCESS"

    attributes = [
        {
            name = "LockID"
            type = "S"
        },
    ]

    tags = {
        Creator = "Fazli"
    }
}

############################
# Infrastructure Resources #
############################