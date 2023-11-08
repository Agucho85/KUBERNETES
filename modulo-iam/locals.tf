# Define Local Values in Terraform
locals {
  environment = var.environment
  name        = var.project

  common_tags = {
    project     = local.name
    environment = local.environment
    managed_by  = "terraform"
  }
  eks_cluster_name = "${var.project}-${var.cluster_name}"
}