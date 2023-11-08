# AWS Availability Zones Datasource
data "aws_availability_zones" "available" {
}

# VPC ID #
data "aws_vpc" "vpc_id" {
  id = "vpc-030849d2e3aefc5a4"
}

# PÚBLIC Subnets #
data "aws_subnets" "vpc_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_id.id]
  }
  tags = {
    Type = "Public Subnets"
  }
}
data "aws_subnet" "vpc_public_subnets" {
  for_each = toset(data.aws_subnets.vpc_public_subnets.ids)
  id       = each.value
}

# PRIVATE Subnets #
data "aws_subnets" "vpc_private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_id.id]
  }
  tags = {
    Type = "private-subnets"
  }
}
data "aws_subnet" "vpc_private_subnets" {
  for_each = toset(data.aws_subnets.vpc_private_subnets.ids)
  id       = each.value
}

# DATABASE Subnets #
data "aws_subnets" "database_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_id.id]
  }
  tags = {
    Type = "database-subnets"
  }
}
data "aws_subnet" "database_subnets" {
  for_each = toset(data.aws_subnets.database_subnets.ids)
  id       = each.value
}

# Database Subnet Group
data "aws_db_subnet_group" "database_subnet_group" {
  name = "default-vpc-030849d2e3aefc5a4"
}

# NAT Gateways - Outbound Communication
data "aws_nat_gateway" "ngs" {
  subnet_id = "subnet-0f1178fc11c9f87fc"
  id        = "nat-05ec5f44107f17dc5"
}