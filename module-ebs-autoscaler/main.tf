# Modulo que crea con helm los recursos: CSI-EBS, autoscaler y metrics.
# Debe ser llamado por el root module despues de creado el grupo de nodos privados.
# Tener en cuenta que el recurso de EBS CSI desplajado con helm utiliza imagenes oficiales de AWS, que puede variar de acuerdo a la region en donde se despliegue el eks, por lo cual se debe modiicar la linea 33.

# Get AWS Account ID
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Install EBS CSI Driver using HELM
# Resource: Helm Release 
resource "helm_release" "ebs_csi_driver" {
  name       = "${var.project}-${var.cluster_name}-aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  namespace  = "kube-system"

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/aws-ebs-csi-driver" # Changes based on Region - This is for us-east-2 Additional Reference: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html for us only change the regiong same account
  }

  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = "ebs-csi-controller-sa"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.ebs_csi_iam_role_arn
  }

}

# Install Cluster Autoscaler using HELM
# Resource: Helm Release 
resource "helm_release" "cluster_autoscaler_release" {
  depends_on = [helm_release.ebs_csi_driver]

  name = "${var.project}-${var.cluster_name}-ca"

  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  namespace = "kube-system"

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_id
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.cluster_autoscaler_iam_role_arn
  }
  # Additional Arguments (Optional) - To Test How to pass Extra Args for Cluster Autoscaler go to https://github.com/kubernetes/autoscaler/tree/master/charts/cluster-autoscaler
  set {
    name  = "extraArgs.scan-interval"
    value = "10s"
  }
}

# Install Kubernetes Metrics Server using HELM
# Resource: Helm Release 
resource "helm_release" "metrics_server_release" {
  name       = "${var.project}-${var.cluster_name}-metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"

  depends_on = [
    helm_release.ebs_csi_driver
  ]
}
