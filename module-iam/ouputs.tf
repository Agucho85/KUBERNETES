# This file contains the output variables for the IAM roles created for the EKS cluster.

output "aws_caller_identity" {
  description = "AWS caller identity"
  value       = var.aws_caller_identity
}

# EKS master role outputs
output "eks_master_role_name" {
  description = "IAM role name of the EKS cluster."
  value       = aws_iam_role.eks_master_role.name
}
output "eks_master_role_arn" {
  description = "IAM MASTER role ARN of the EKS cluster."
  value       = aws_iam_role.eks_master_role.arn
}

# EKS Node Group Outputs - Private
output "eks_nodegroup_role_name" {
  description = "IAM NODEGROUP role ARN of the EKS cluster."
  value       = aws_iam_role.eks_nodegroup_role.name
}
output "eks_nodegroup_role_arn" {
  description = "IAM NODEGROUP role ARN of the EKS cluster."
  value       = aws_iam_role.eks_nodegroup_role.arn
}

# EKS Admin role outputs
output "eks_admin_role_arn" {
  description = "IAM ADMIN role ARN of the EKS cluster."
  value       = aws_iam_role.eks_admin_role.arn
}
output "eks_admin_role_name" {
  description = "IAM ADMIN role ARN of the EKS cluster."
  value       = aws_iam_role.eks_admin_role.name
}

# EKS Developer role outputs
output "eks_developer_role_arn" {
  description = "IAM DEVELOPER role ARN of the EKS cluster."
  value       = aws_iam_role.eks_developer_role.arn
}
output "eks_developer_role_name" {
  description = "IAM DEVELOPER role ARN of the EKS cluster."
  value       = aws_iam_role.eks_developer_role.name
}