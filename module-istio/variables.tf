# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
}

# Business Division
variable "project" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
}

# EKS OIDC ROOT CA Thumbprint - valid until 2037
variable "eks_oidc_root_ca_thumbprint" {
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  type        = string
}

# Variable para agregar mas usuarios al assume rol de eks-admin con sts
variable "users_admin" {
  description = "User to add as admin in eks."
  type        = set(string)
}
variable "users_developers" {
  description = "User to add as admin in eks."
  type        = set(string)
}

# EKS Cluster Input Variables
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
  type        = string
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
}

# EKS Node Group Variables
## Placeholder space you can create if required

variable "capacity_type_private" {
  description = "Especify what kind od capacity do you need for cluster ON_DEMAND or SPOT"
  type        = string
}

variable "disk_size_private" {
  description = "Especify the size of the disk do you need "
  type        = string
}

variable "instance_types_private" {
  description = "Especify the type of the EC2 do you need"
  type        = list(string)
  default     = ["t3a.large"]
}

variable "desired_size_private" {
  description = "Desired size of de autoscaling group in private node gruop."
  type        = string
}

variable "min_size_private" {
  description = "Minimum size of de autoscaling group in private node gruop."
  type        = string
}

variable "max_size_private" {
  description = "Maximum size of de autoscaling group in private node gruop."
  type        = string
}

variable "namespace" {
  description = "Especify the namespace to create"
  type        = list(string)
}

# EKS ConfigMap Variables
variable "eks_master_role_arn" {
  description = "ARN of the IAM Role that provides permissions for the EKS Cluster."
  type        = string
}

variable "eks_master_role_name" {
  description = "Name of the IAM Role that provides permissions for the EKS Cluster."
  type        = string
}

variable "eks_nodegroup_role_arn" {
  description = "ARN of the IAM Role that provides permissions for the EKS Node Group."
  type        = string
}

variable "eks_nodegroup_role_name" {
  description = "Name of the IAM Role that provides permissions for the EKS Node Group."
  type        = string
}

variable "eks_admin_role_arn" {
  description = "ARN of the IAM ADMIN Role that provides permissions for the EKS Node Group."
  type        = string
}

variable "eks_admin_role_name" {
  description = "Name of the IAM ADMIN Role that provides permissions for the EKS Node Group."
  type        = string
}

variable "eks_developer_role_arn" {
  description = "ARN of the IAM DEVELOPER Role that provides permissions for the EKS Node Group."
  type        = string
}

variable "eks_developer_role_name" {
  description = "Name of the IAM DEVELOPER Role that provides permissions for the EKS Node Group."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC."
  type        = string
}

variable "vpc_region" {
  description = "Region in which VPC is created."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "vpc_public_subnets" {
  description = "List of public subnets in the VPC."
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "List of private subnets in the VPC."
  type        = list(string)
}

variable "vpc_database_subnets" {
  description = "List of database subnets in the VPC."
  type        = list(string)
}

variable "vpc_database_subnet_group" {
  description = "Database subnet group in the VPC."
  type        = string
}

variable "nat_gateway_ips" {
  description = "List of NAT Gateway IPs in the VPC."
  type        = string
}
