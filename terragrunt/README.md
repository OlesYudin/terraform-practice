# Simple module infrastructure with Terraform/Terragrunt

In this demo you can see simple modules that can be provision in multi environments.

## Module

### Structure of modules

<p align="center">
  <img src="image/Module structure.png" alt="Scheme of network"/>
</p>

### Resources in modules

| Module  | Resources                                                                                                                                   | Description                                                               |
| ------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| s3      | aws_s3_bucket                                                                                                                               | Only create aws s3 bucket without additional configurations               |
| network | - aws_vpc <br> - aws_internet_gateway <br> - aws_subnet <br> - aws_route_table <br> - aws_route_table_association <br> - aws_security_group | Create VPC with IGW, 2 public subnets and Security Group for EC2 instance |
