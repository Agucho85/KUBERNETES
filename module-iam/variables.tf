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

variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
}

# Variable para aws_caller_identity
variable "aws_caller_identity" {
  description = "AWS caller identity"
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
