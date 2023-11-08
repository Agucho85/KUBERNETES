## Resource: Persistent Volume Claim
#resource "kubernetes_persistent_volume_claim_v1" "efs_pvc" {
#  metadata {
#    name = "efs-claim"
#  }
#  depends_on = [ 
#    aws_eks_cluster.eks_cluster, 
#    kubectl_manifest.cni_docs,
#    aws_efs_file_system.efs_file_system
#    ]
#  spec {
#    access_modes       = ["ReadWriteMany"]
#    storage_class_name = kubernetes_storage_class_v1.efs_sc.metadata[0].name
#    resources {
#      requests = {
#        storage = "5Gi"
#      }
#    }
#  }
#}
#
## Storage Size (storage = "5Gi")
### You can specify any size for the persistent volume in the storage field. 
### Kubernetes requires this field, but because Amazon EFS is an 
### elastic file system, it does not enforce any file system capacity. 