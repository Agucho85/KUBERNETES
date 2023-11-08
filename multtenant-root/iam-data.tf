#IAM data source
# Data Source de eks_master_role
data "aws_iam_role" "eks_master_role" {
  name = "dirmod-eks-master-role"
}
output "eks_master_role_arn" {
  description = "IAM MASTER role ARN of the EKS cluster."
  value       = data.aws_iam_role.eks_master_role.arn
}

# Data Source de eks_nodegroup_role
data "aws_iam_role" "eks_nodegroup_role" {
  name = "dirmod-eks-nodegroup-role"
}
output "eks_nodegroup_role_arn" {
  description = "IAM NODEGROUP role ARN of the EKS cluster."
  value       = data.aws_iam_role.eks_nodegroup_role.arn
}

# Data Source de eks_admin_role
data "aws_iam_role" "eks_admin_role" {
  name = "dirmod-eks-admin-role"
}
output "eks_admin_role_arn" {
  description = "IAM EKS ADMIN role ARN of the EKS cluster."
  value       = data.aws_iam_role.eks_admin_role.arn
}

# Data Source de eks_developer_role
data "aws_iam_role" "eks_developer_role" {
  name = "dirmod-eks-readonly-role"
}
output "eks_developer_role_arn" {
  description = "IAM EKS DEVELOPER role ARN of the EKS cluster."
  value       = data.aws_iam_role.eks_developer_role.arn
}

# Data Source de ebs_csi_iam_role
data "aws_iam_role" "ebs_csi_iam_role" {
  name = "dirmod-ebs-csi-iam-role"
}
output "ebs_csi_iam_role" {
  description = "IAM NODEGROUP role ARN of the EKS cluster."
  value       = data.aws_iam_role.ebs_csi_iam_role.arn
}

# Data Source de cluster_autoscaler_iam_role
data "aws_iam_role" "cluster_autoscaler_iam_role" {
  name = "dirmod-cluster-autoscaler"
}
output "cluster_autoscaler_iam_role" {
  description = "IAM NODEGROUP role ARN of the EKS cluster."
  value       = data.aws_iam_role.cluster_autoscaler_iam_role.arn
}

# Data Source de lbc_iam_role
data "aws_iam_role" "lbc_iam_role" {
  name = "dirmod-lbc-iam-role"
}
output "lbc_iam_role" {
  description = "IAM Load balancer role ARN of the EKS cluster."
  value       = data.aws_iam_role.lbc_iam_role.arn
}