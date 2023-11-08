# VPC Input Variables

# VPC CIDR Block
variable "vpc_id" {
  description = "VPC ID of the VPC"
  type        = string
  default     = "vpc-030849d2e3aefc5a4"
}

variable "subnet_dirmod-multitenant-public-us-east-1a_id" {
  description = "subnet ID of the VPC"
  type        = string
  default     = "subnet-0f1178fc11c9f87fc"
}

variable "subnet_dirmod-multitenant-private-us-east-1a" {
  description = "subnet ID of the VPC"
  type        = string
  default     = "subnet-03583458e126960c6"
}

variable "subnet_dirmod-multitenant-db-us-east-1a" {
  description = "subnet ID of the VPC"
  type        = string
  default     = "subnet-065ff0c2ff8e12555"
}

variable "subnet_dirmod-multitenant-public-us-east-1b" {
  description = "subnet ID of the VPC"
  type        = string
  default     = "subnet-09d41d7be8777bc14"
}

variable "subnet_dirmod-multitenant-private-us-east-1b" {
  description = "subnet ID of the VPC"
  type        = string
  default     = "subnet-0aa753a023516a680"
}

variable "subnet_dirmod-multitenant-db-us-east-1b" {
  description = "subnet ID of the VPC"
  type        = string
  default     = "subnet-043309c33dcc9865a"
}

# VPC CIDR Block
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





