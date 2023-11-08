# This file contains the output variables for the IAM roles created for the EKS cluster.
/* # EKS master role outputs
output "eks_master_role_name" {
  description = "IAM role name of the EKS cluster."
  value       = module.iam.eks_master_role_name
}
output "eks_master_role_arn" {
  description = "IAM MASTER role ARN of the EKS cluster."
  value       = module.iam.eks_master_role_arn
}

# EKS Node Group Outputs - Private
output "eks_nodegroup_role_arn" {
  description = "IAM NODEGROUP role ARN of the EKS cluster."
  value       = module.iam.eks_nodegroup_role_arn
}
output "eks_nodegroup_role_name" {
  description = "IAM NODEGROUP role ARN of the EKS cluster."
  value       = module.iam.eks_nodegroup_role_name
}

# EKS Admin role outputs
output "eks_admin_role_arn" {
  description = "IAM ADMIN role ARN of the EKS cluster."
  value       = module.iam.eks_admin_role_arn
}
output "eks_admin_role_name" {
  description = "IAM ADMIN role ARN of the EKS cluster."
  value       = module.iam.eks_admin_role_name
}

# EKS Developer role outputs
output "eks_developer_role_arn" {
  description = "IAM DEVELOPER role ARN of the EKS cluster."
  value       = module.iam.eks_developer_role_arn
}
output "eks_developer_role_name" {
  description = "IAM DEVELOPER role ARN of the EKS cluster."
  value       = module.iam.eks_developer_role_name
} */

# EKS Cluster Outputs
output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = module.eks.cluster_id
}

output "cluster_name" {
  description = "The name/id of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = module.eks.cluster_arn
}

output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = module.eks.cluster_certificate_authority_data
}

output "aws_iam_openid_connect_provider_arn" {
  description = "AWS IAM Open ID Connect Provider ARN"
  value       = module.eks.aws_iam_openid_connect_provider_arn
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.eks.cluster_oidc_issuer_url
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = module.eks.cluster_version
}

output "cluster_primary_security_group_id" {
  description = "The cluster primary security group ID created by the EKS cluster on 1.14 or later. Referred to as 'Cluster security group' in the EKS console."
  value       = module.eks.cluster_primary_security_group_id
}

# EKS Node Group Outputs - Private
output "node_group_private_id" {
  description = "Node Group 1 ID"
  value       = module.private_node_group.node_group_private_id
}

output "node_group_private_arn" {
  description = "Private Node Group ARN"
  value       = module.private_node_group.node_group_private_arn
}

output "node_group_private_status" {
  description = "Private Node Group status"
  value       = module.private_node_group.node_group_private_status
}

output "node_group_private_version" {
  description = "Private Node Group Kubernetes Version"
  value       = module.private_node_group.node_group_private_version
}

# EBS CSI Helm Release Outputs
output "ebs_csi_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = module.ebs_autoscaler.ebs_csi_helm_metadata
}

# Helm Release Outputs
output "cluster_autoscaler_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = module.ebs_autoscaler.cluster_autoscaler_helm_metadata
}

# Helm Release Outputs
output "lbc_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = module.loadbalancer.lbc_controller_metadata
}