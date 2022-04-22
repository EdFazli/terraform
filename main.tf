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

  tags {
      Creator = "Fazli"
  }

}

module "dynamodb_tfstate_lock" {
    source = "terraform-aws-modules/dynamodb-table/aws"

    name = "fazli-terraform-statefile-lock"
    hash_key = "id"
    range_key = "title"

    attributes = [
        {
            name = "id"
            type = "N"
        },
        {
            name = "title"
            type = "S"
        },
        {
            name = "age"
            type = "N"
        }
    ]

    tags = {
        Creator = "Fazli"
    }
}

############################
# Infrastructure Resources #
############################