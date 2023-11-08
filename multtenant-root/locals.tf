# Define Local Values in Terraform
locals {
  common_tags = {
    project     = var.project
    environment = var.environment
    managed_by  = "terraform"
  }
  eks_cluster_name = "${var.project}-${var.cluster_name}"
}