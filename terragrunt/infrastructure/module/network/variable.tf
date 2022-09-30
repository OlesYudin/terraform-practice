variable "vpc_cidr" {
  type = string
}
variable "main_public_subnet" {
  type = list(string)
}
variable "ec2_main_sg" {
  type = map(list(any))
}
# Map of tags for AWS resources
# variable "local_tags" {}
