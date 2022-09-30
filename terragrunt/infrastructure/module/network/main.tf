# terraform {
#   required_version = "~>1.2.9" # use specific version of Terraform
#   # Specify AWS version
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }
# Get available AZ in AWS region
data "aws_availability_zones" "available" {
  state = "available"
}
# Create VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc_cidr
  tags = merge(
    var.local_tags,
    { Name = "${var.local_tags.project_name}-${var.local_tags.env}-main-VPC" }
  )
}
# Create Intenet Gateway for main-vpc
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = merge(
    var.local_tags,
    { Name = "${var.local_tags.project_name}-${var.local_tags.env}-main-IGW" }
  )
}
# Create 2 subnets in 2 different AZ
# Example: 
# us-east-2a with subnet 10.0.0.0/24
# us-east-2b with subnet 10.0.1.0/24
resource "aws_subnet" "main-public-subnet" {
  count = length(var.main_public_subnet)
  #name              = "${var.local_tags.name}-${var.local_tags.env}-main-public-subnet-${count.index + 1}"
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.main_public_subnet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index] # create subnet in 2 different AZ

  tags = merge(
    var.local_tags,
    { Name = "${var.local_tags.project_name}-${var.local_tags.env}-main-public-subnet-${count.index + 1}" }
  )
}

# Create route table for 2 public subnet
resource "aws_route_table" "main-public-subnet-rt" {
  count  = length(var.main_public_subnet)
  vpc_id = aws_vpc.main-vpc.id

  route {
    # cidr_block = var.main_public_subnet[count.index]
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }

  tags = merge(
    var.local_tags,
    { Name = "${var.local_tags.project_name}-${var.local_tags.env}-main-public-subnet-RT-${count.index + 1}" }
  )
}

# Create association for public route table
resource "aws_route_table_association" "a" {
  count          = length(var.main_public_subnet)
  subnet_id      = aws_subnet.main-public-subnet[count.index].id
  route_table_id = aws_route_table.main-public-subnet-rt[count.index].id
}


