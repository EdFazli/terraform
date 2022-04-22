# Terraform

The reference repository for terraform project

## Pre-requisites

1. AWS credentials has been configured
2. S3 bucket and dynamodb table for state management must be created first. Then import them into terraform
3. create .gitignore file and list down confidential files including .terraform.lock.hcl

Below resources will use **terraform-aws-module** as source reference

- Security Groups - *terraform-aws-modules/security-group/aws*
- S3 Bucket - *terraform-aws-modules/s3-bucket/aws*
- S3 Object - *terraform-aws-modules/s3-bucket/aws//modules/object*
- Redshift - *terraform-aws-modules/redshift/aws*
- EC2 Keypair - *terraform-aws-modules/key-pair/aws*
