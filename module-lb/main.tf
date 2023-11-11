# Modulo crea el load balancer.
# Debe ser llamado por el root module despues de creado el modulo de grupo d enodos privados, dsps de los modulo de iam-addons.
# Tener en cuenta que el recurso de lb desplajado con helm utiliza imagenes oficiales de AWS, que puede variar de acuerdo a la region en donde se despliegue el eks, por lo cual se debe modiicar la linea 25.

# Get AWS Account ID
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Install AWS Load Balancer Controller using HELM
# Resource: Helm Release 
resource "helm_release" "loadbalancer_controller" {
  name       = "${var.project}-${var.cluster_name}-aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  namespace = "kube-system"

  # Value changes based on your Region (Below is for us-east-1)
  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.lbc_iam_role_arn
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "region"
    value = var.aws_region
  }

  set {
    name  = "clusterName"
    value = var.cluster_id
  }
}