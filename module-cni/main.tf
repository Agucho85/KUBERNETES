resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = "${var.project}-${var.cluster_name}"
  addon_name                  = "vpc-cni"
  addon_version               = "v1.14.1-eksbuild.1"
  resolve_conflicts_on_update = "PRESERVE"

  tags = {
    "eks_addon" = "vpc-cni"
  }

  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${var.project}-${var.cluster_name} && kubectl set env daemonset aws-node -n kube-system ENABLE_PREFIX_DELEGATION=true && kubectl set env daemonset aws-node -n kube-system WARM_ENI_TARGET=3 && kubectl set env daemonset aws-node -n kube-system WARM_IP_TARGET=5"
  }
}

output "enable_prefix_delegation" {
  description = "CMD for enable prefix delegation"
  # value       = null_resource.enable_prefix_delegation
  value = aws_eks_addon.vpc_cni
}
