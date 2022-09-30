# Output VPC id
output "vpc_id" {
  value = aws_vpc.main-vpc.id
}
output "subnet_id" {
  value = aws_subnet.main-public-subnet[*].id
}
output "ec2_main_sg_id" {
  value = aws_security_group.main-ec2-sg.id
}
