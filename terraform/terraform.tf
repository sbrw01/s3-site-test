# Providers
# Default provider
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
  version = "~> 2.59.0"
}

# Required to provision Cloudfront distribution and ACM certifica in us-east-1  
provider "aws" {
  alias = "global"
  region = "us-east-1"
}

# Default labels for resources
locals {
  terraform_tags = {
    team       = "platform"
    project    = "S3 static website"
    managed_by = "terraform"
    git_repo   = ""
  }
}


# Required to set up remote terraform state file
# terraform {
#   backend "s3" {
#     skip_credentials_validation = true
#     bucket = "checkout-terraform-state"
#     key = "checkout-terraform.tfstate"
#     region = "eu-west-2"
#   }
# }