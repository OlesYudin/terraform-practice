terraform {
  source = "../../../module//network"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  vpc_cidr           = "10.0.0.0/16"                  # Default CIDR for VPC
  main_public_subnet = ["10.0.0.0/24", "10.0.1.0/24"] # Default CIDR for public subnets
  ec2_main_sg = {
    "22"  = ["0.0.0.0/0"]
    "80"  = ["0.0.0.0/0"]
    "443" = ["0.0.0.0/0"]
  }
}