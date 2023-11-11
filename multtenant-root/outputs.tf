# This file contains the output variables for the IAM roles created for the EKS cluster.

/*  outputs. modulo VPC
# VPC Output Values

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# VPC CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# VPC database_subnets
output "database_subnets" {
  description = "List of IDs of database_subnets"
  value       = module.vpc.database_subnets
}

# VPC database_subnet_group_name
output "database_subnet_group_name" {
  description = "List of IDs of database_subnet_group_name"
  value       = module.vpc.database_subnet_group_name
}

# VPC NAT gateway Public IP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# VPC AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}
*/

/* outputs. modulo iam
# EKS master role outputs
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
}
*/

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

/*
output "ebs_csi_iam_policy_arn" {
  value = modulo.iam_addons.ebs_csi_iam_policy_arn
}

output "ebs_csi_iam_policy" {
  value = modulo.iam_addons.ebs_csi_iam_policy
}

output "ebs_csi_iam_role_arn" {
  description = "EBS CSI IAM Role ARN"
  value       = modulo.iam_addons.ebs_csi_iam_role_arn
}

output "cluster_autoscaler_iam_role_arn" {
  description = "Cluster Autoscaler IAM Role ARN"
  value       = modulo.iam_addons.cluster_autoscaler_iam_role_arn
}

output "lbc_iam_policy_arn" {
  value = modulo.iam_addons.lbc_iam_policy_arn
}

output "lbc_iam_role_arn" {
  description = "AWS Load Balancer Controller IAM Role ARN"
  value       = modulo.iam_addons.lbc_iam_role_arn
}

output "cni_iam_role_arn" {
  description = "CNI IAM Role ARN"
  value       = modulo.iam_addons.cni_iam_role_arn
}

output "cni_iam_policy_arn" {
  value = modulo.iam_addons.cni_iam_policy_arn
}

*/
# Module CNI output
output "enable_prefix_delegation" {
  description = "CMD for enable prefix delegation"
  value = module.cni.enable_prefix_delegation
}

# EBS CSI Helm Release Outputs for ebs_csi_helm_metadata
output "ebs_csi_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = module.ebs_autoscaler.ebs_csi_helm_metadata
}

# Helm Release Outputs for cluster_autoscaler_helm_metadata
output "cluster_autoscaler_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = module.ebs_autoscaler.cluster_autoscaler_helm_metadata
}

# Helm Release Outputs for lbc_helm_metadata
output "lbc_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = module.loadbalancer.lbc_controller_metadata
}

# Helm Release Outputs for metrics_server_helm_metadata
output "metrics_server_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = module.ebs_autoscaler.metrics_server_helm_metadata
}

/* module namespaces
output "namespaces" {
  description = "Namespaces created"
  value       = module.namespaces.namespaces
}
*/