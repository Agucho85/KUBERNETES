# Get AWS Account ID
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
data "aws_ssm_parameter" "latest_eks_optimized_ami" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "test_template" {
  name_prefix   = "test_template"
  image_id      = data.aws_ssm_parameter.latest_eks_optimized_ami.value
  instance_type = var.instance_type_private
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = var.disk_size_private
      volume_type = "gp2"
    }
  }
  # Only necesary if you  are setting-up SPOT nodes
  # instance_market_options {
  #   market_type = var.capacity_type_private
  # }

  user_data = base64encode(templatefile("${path.module}/user_data.tpl", { max_pods = 110, cluster = "${var.project}-${var.cluster_name}"}))
}


# Create AWS EKS Node Group - Private
resource "aws_eks_node_group" "eks_ng_private" {
  depends_on      = [aws_launch_template.test_template]
  cluster_name    = "${var.project}-${var.cluster_name}"
  node_group_name = "${var.project}-eks-ng-private"
  node_role_arn   = var.eks_nodegroup_role_arn
  subnet_ids      = var.vpc_private_subnets
  scaling_config {
    desired_size = var.desired_size_private
    min_size     = var.min_size_private
    max_size     = var.max_size_private
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1
  }
  launch_template {
    id      = aws_launch_template.test_template.id
    version = "$Latest"
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  # depends_on = [kubernetes_config_map_v1.aws_auth
  # ]
  tags = merge(local.common_tags,
    {
      Name = "Private-Node-Group"
      # Cluster Autoscaler Tags
      "k8s.io/cluster-autoscaler/${var.project}-${var.cluster_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"                            = "TRUE"
  })
}
