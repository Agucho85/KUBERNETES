# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}

# Business Division
variable "project" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
}

# EKS Cluster Input Variables
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
}
variable "cluster_id" {
  description = "ID of the EKS cluster."
  type        = string
}

# IAM DATA
variable "ebs_csi_iam_role_arn" {
  description = "ARN of the ebs_csi_role."
  type        = string
}
variable "cluster_autoscaler_iam_role_arn" {
  description = "ARN of the cluster_autoscaler_iam_role_arn."
  type        = string
}