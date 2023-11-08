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
  default     = "dirmod"
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
    "agustin.ahumada@dirmod.com",
    "agustin.manessi@dirmod.com",
    "diego.miguel@dirmod.com"
    # "Terraform-CREAR!"
  ]
}
variable "users_developers" {
  description = "User to add as admin in eks."
  type        = set(string)
  default = [
    "alejandro.alazraqui@dirmod.com",
    "ramon.carrasquero@dirmod.com",
    "roberto.company@dirmod.com",
    "anibal.gil.bermudez@dirmod.com"
  ]
}

# EKS Cluster Input Variables
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default     = "test44"
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
  default     = "t3.medium"
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
    "aysa",
    "aolas",
    "ocp",
    "legal-run"
  ]
}

# # VPC Input Variables
# variable "vpc_id" {
#   description = "ID of the VPC."
#   type        = string
#   default     = data.aws_vpc.vpc_id.id
# }

# variable "vpc_cidr_block" {
#   description = "CIDR block for the VPC."
#   type        = string
#   default     = data.aws_vpc.vpc_cidr_block.cidr_block
# }

# variable "vpc_region" {
#   description = "Region in which VPC is created."
#   type        = string
#   default     = data.aws_vpc.region.region
# }

# variable "vpc_public_subnets" {
#   description = "List of public subnets in the VPC."
#   type        = list(string)
#   default     = data.aws_subnet_ids.vpc_public_subnets.ids
# }

# variable "vpc_private_subnets" {
#   description = "List of private subnets in the VPC."
#   type        = list(string)
#   default     = data.aws_subnet_ids.vpc_private_subnets.ids
# }

# variable "vpc_database_subnets" {
#   description = "List of database subnets in the VPC."
#   type        = list(string)
#   default     = data.aws_subnet_ids.database_subnets.ids
# }

# variable "vpc_database_subnet_group" {
#   description = "Database subnet group in the VPC."
#   type        = string
#   default     = data.aws_db_subnet_group.database_subnet_group.name
# }

# variable "nat_gateway_ips" {
#   description = "List of NAT Gateway IPs in the VPC."
#   type        = list(string)
#   default     = data.aws_nat_gateway_ids.ngs.ids
# }
