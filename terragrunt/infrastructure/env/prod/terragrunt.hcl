# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket  = "04lesson-${local.env}-terragrunt-tfstate"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = local.region
    encrypt = true
    # dynamodb_table = "04lesson-terragrunt-tfstate-table"
  }
}

# Generate an AWS provider block
generate "provider" {
  path      = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = "~>1.2.9" # use specific version of Terraform
  # Specify AWS version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.33.0" # use specific version of AWS provider
    }
  }
}
provider "aws" {
  region = var.region
  default_tags {
    tags = var.local_tags
  }
}
variable "region" {}
variable "local_tags" {
  type = map(string)
}
EOF
}

locals {
  region = "us-east-2"
  env    = "prod"
}

# Global variables that will add to all modules
inputs = {
  region = local.region
  env    = local.env
  local_tags = {
    "project_name" = "04lesson",
    "env"          = "prod",
    "Team"         = "DevOps",
    "DeployedBy"   = "Terraform",
    "OwnerEmail"   = "student@gmail.com",
    "Owner"        = "Student"
  }
}