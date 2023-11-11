# Modulo que crea la VPC y todo los relacionado con el networking del EKS. Debe ser el primer modulo llamado por el root module.
# A diferencia de los otro child modulos, este no crea el recurso directamente sino que utiliza un modulo ya especificado en AWS.

# Get AWS Account ID
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# AWS Availability Zones Datasource
data "aws_availability_zones" "available" {
}

# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version= "5.1.2"
  #version = "~> 3.11"

  # VPC Basic Details
  name            = "${var.project}-${var.cluster_name}"
  cidr            = var.vpc_cidr_block
  azs             = var.vpc_availability_zones
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets

  # Database Subnets
  database_subnets                   = var.vpc_database_subnets
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  # create_database_internet_gateway_route = true
  # create_database_nat_gateway_route = true

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags     = local.common_tags
  vpc_tags = local.common_tags

  # Additional Tags to Subnets
  public_subnet_tags = merge(local.common_tags,
    {
      Type                                              = "Public Subnets"
      "kubernetes.io/role/elb"                          = 1
      "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  })
  private_subnet_tags = merge(local.common_tags,
    {
      Type                                              = "private-subnets"
      "kubernetes.io/role/internal-elb"                 = 1
      "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  })

  database_subnet_tags = merge(local.common_tags,
    {
      Type = "database-subnets"
  })
}