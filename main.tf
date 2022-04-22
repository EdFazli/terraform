########################################################################
# Backend Statefile Resources                                          #
########################################################################

module "s3_statefile" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                    = "fazli-terraform-statefile"
  block_public_acls         = true
  block_public_policy       = true
  ignore_public_acls        = true
  restrict_public_buckets   = true

  versioning = {
    enabled = true
  }

  tags = {
      Creator   = "Fazli"
      Terraform = "True"
  }

}

module "dynamodb_tfstate_lock" {
    source = "./modules/dynamodb-table"

    name            = "fazli-terraform-statefile-lock"
    hash_key        = "LockID"
    billing_mode    = "PAY_PER_REQUEST"
    table_class     = "STANDARD_INFREQUENT_ACCESS"

    attributes = [
        {
            name = "LockID"
            type = "S"
        },
    ]

    tags = {
        Creator   = "Fazli"
        Terraform = "True"
    }
}

########################################################################
# Data Sources                                                         #
########################################################################

data "aws_ami" "amazon_windows" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "manifest-location"
    values = ["amazon/Windows_Server-2019-English-Full-Base*"]
  }
  filter {
    name = "platform"
    values = ["windows"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  tags = {
    Creator = "Fazli"  
    Terraform = "True"
  }

}
########################################################################
# Infrastructure Resources                                             #
########################################################################

#-------------------------------VPC------------------------------------#

#-------------------------------VPC------------------------------------#

#--------------------------------SG------------------------------------#
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.prod-vpc.vpc_id

  ingress_cidr_blocks = ["10.10.0.0/16"]
}
#--------------------------------SG------------------------------------#

#-----------------------------KEYPAIR----------------------------------#
resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "fazli-keypair"
  public_key = tls_private_key.this.public_key_openssh

  tags = {
      Creator   = "Fazli"
      Terraform = "True"
  }
}
#-----------------------------KEYPAIR----------------------------------#

#-------------------------------EC2------------------------------------#
module "instance1" {
  source  = "./modules/ec2"

  name = "Instance-1"

  ami                    = data.aws_ami.amazon_windows.id
  instance_type          = "t2.micro"
  key_name               = "fazli-keypair"
  monitoring             = false
  vpc_security_group_ids = [module.web_server_sg.security_group_id]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Creator   = "Fazli"
    Terraform = "True"
  }
}
#-------------------------------EC2------------------------------------#

#--------------------------------S3------------------------------------#

#--------------------------------S3------------------------------------#

#-----------------------------REDSHIFT---------------------------------#

#-----------------------------REDSHIFT---------------------------------#