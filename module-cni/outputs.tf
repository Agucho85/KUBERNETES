output "enable_prefix_delegation" {
  description = "CMD for enable prefix delegation"
  # value       = null_resource.enable_prefix_delegation
  value = aws_eks_addon.vpc_cni
}
