# Resource: Kubernetes Storage Class
resource "kubernetes_storage_class_v1" "efs_sc" {
  metadata {
    name = "multitenant-sc"
  }
  depends_on = [
    aws_eks_cluster.eks_cluster,
    kubectl_manifest.cni_docs,
    aws_efs_file_system.efs_file_system
  ]
  storage_provisioner = "efs.csi.aws.com"
  parameters = {
    provisioningMode = "efs-ap"
    fileSystemId     = aws_efs_file_system.efs_file_system.id
    directoryPerms   = "700"
    gidRangeStart    = "1000"         # optional
    gidRangeEnd      = "2000"         # optional
    basePath         = "/efs-dynamic" # optional
  }
}