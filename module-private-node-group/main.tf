# Modulo que crea los recursos: el grupo de nodos privados, el rbac del cluster.
# Debe ser llamado por el root module despues de creado el eks y los addons.

# Get AWS Account ID
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
data "aws_ssm_parameter" "latest_eks_optimized_ami" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2/recommended/image_id"
}

# This set-up the template for the nodes in the private gruop, it uses the latest vm-template from AWS optimze for EKS and the user_data.tpl to configure the posibility to have more ips in each node for more pods to be deploy in them. Limitation you can not set SPOT instances with a template like this.
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

  tags = merge(local.common_tags,
    {
      Name = "Private-Node-Group"
      # Cluster Autoscaler Tags - if karpenter is implemented this should be modify.
      "k8s.io/cluster-autoscaler/${var.project}-${var.cluster_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"                            = "TRUE"
  })
}
