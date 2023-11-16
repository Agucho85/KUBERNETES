# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-1"
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "non-prod"
}

# Business Division
variable "project" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
  default     = "project"
}

# OIDC ROOT CA Thumbprint - valid until 2037
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

# Variable para agregar mas usuarios al assume rol de eks-admin con sts
variable "users_admin" {
  description = "User to add as admin in eks."
  type        = set(string)
  default = [
    "bar@foo.com"
  ]
}
variable "users_developers" {
  description = "User to add as admin in eks."
  type        = set(string)
  default = [
    "bar@foo.com"
  ]
}

# EKS Cluster Input Variables
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default     = "test"
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
  default     = "172.20.0.0/16"
}

variable "cluster_version" {
  description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
  type        = string
  default     = "1.28"
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EKS Node Group Variables
## Placeholder space you can create if required

variable "capacity_type_private" {
  description = "Especify what kind od capacity do you need for cluster ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size_private" {
  description = "Especify the size of the disk do you need "
  type        = string
  default     = "10"
}

variable "instance_type_private" {
  description = "Especify the type of the EC2 do you need"
  type        = string
  default     = "t3.small"
}

variable "desired_size_private" {
  description = "Desired size of de autoscaling group in private node gruop."
  type        = string
  default     = "1"
}

variable "min_size_private" {
  description = "Minimum size of de autoscaling group in private node gruop."
  type        = string
  default     = "1"
}

variable "max_size_private" {
  description = "Maximum size of de autoscaling group in private node gruop."
  type        = string
  default     = "4"
}

variable "namespace" {
  description = "Especify the namespace to create"
  type        = list(string)
  default = [
    "foo"
  ]
}

/*
# # VPC Input Variables
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

# VPC Availability Zones
variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}


# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}


# VPC Database Subnets
variable "vpc_database_subnets" {
  description = "VPC Database Subnets"
  type        = list(string)
  default     = ["10.0.151.0/24", "10.0.152.0/24"]
}

# VPC Create Database Subnet Group (True / False)
variable "vpc_create_database_subnet_group" {
  description = "VPC Create Database Subnet Group"
  type        = bool
  default     = true
}

# VPC Create Database Subnet Route Table (True or False)
variable "vpc_create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type        = bool
  default     = true
}


# VPC Enable NAT Gateway (True or False) 
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type        = bool
  default     = true
}

# VPC Single NAT Gateway (True or False)
variable "vpc_single_nat_gateway" {
  description = "Enable only single NAT Gateway in one Availability Zone to save costs"
  type        = bool
  default     = true
}
*/
