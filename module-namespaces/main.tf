# Get AWS Account ID
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Create AWS EKS Node Group - Private
locals {
  namespace_tags = {
    "ManagedBy"       = "Terraform"
    "istio-injection" = "enabled"
  }
}
resource "kubernetes_namespace" "namespace" {
  for_each = toset(var.namespace)

  metadata {
    name   = each.value
    labels = local.namespace_tags
  }
}