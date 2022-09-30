resource "aws_security_group" "main-ec2-sg" {
  name        = "main-ec2-SG"
  description = "Allow SSH and HTTP/HTTPs trafic for ec2 instance"
  vpc_id      = aws_vpc.main-vpc.id

  dynamic "ingress" {
    for_each = var.ec2_main_sg
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.local_tags,
    { Name = "${var.local_tags.project_name}-${var.local_tags.env}-main-ec2-SG" }
  )
}
