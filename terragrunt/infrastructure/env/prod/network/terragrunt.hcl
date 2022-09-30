terraform {
  source = "../../../module//network"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  vpc_cidr           = "172.16.0.0/16"                    # Default CIDR for VPC
  main_public_subnet = ["172.16.0.0/24", "172.16.1.0/24"] # Default CIDR for public subnets
  ec2_main_sg = {
    "22"  = ["0.0.0.0/0"]
    "80"  = ["0.0.0.0/0"]
    "443" = ["0.0.0.0/0"]
  }
}