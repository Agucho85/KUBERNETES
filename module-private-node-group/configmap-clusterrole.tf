# Sample Role Format: arn:aws:iam::180789647333:role/hr-dev-eks-nodegroup-role
# Locals Block
locals {
  configmap_roles = [
    {
      rolearn  = var.eks_nodegroup_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    },
    {
      rolearn  = var.eks_admin_role_arn
      username = "${var.project}-admin"
      groups   = ["system:masters"]
    },
    {
      rolearn  = var.eks_developer_role_arn
      username = "${var.project}-developer"
      groups   = ["${kubernetes_cluster_role_binding_v1.eksdeveloper_clusterrolebinding.subject[0].name}"]
  }]
}


# Resource: Kubernetes Config Map
resource "kubernetes_config_map_v1" "aws_auth" {
  depends_on = [kubernetes_cluster_role_binding_v1.eksdeveloper_clusterrolebinding]
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    mapRoles = yamlencode(local.configmap_roles)
  }
}

# Resource: Cluster Role
resource "kubernetes_cluster_role_v1" "eksdeveloper_clusterrole" {
  metadata {
    name = "${var.project}-eksdeveloper-clusterrole"
  }
  rule {
    api_groups = [""] # These come under core APIs - kubernetes CORE APIS
    resources  = ["nodes", "namespaces", "events", "configmaps", "endpoints", "persistentvolumeclaims", "persistentvolumeclaims/status", "replicationcontrollers/status", "resourcequotas", "resourcequotas/status", "pods", "replicationcontrollers", "replicationcontrollers/scale", "serviceaccounts", "services", "services/status", "ingresses", "ingresses/status", "networkpolicies"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["pods", "bindings", "limitranges", "pods/logs", "pods/portfowarnd", "events", "serviceaccounts", "services", "deployments", "daemonsets", "statefulsets", "replicasets"]
    verbs      = ["get", "list", "watch", "create", "delete", "update", "patch"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list", "watch"]
  }
}
# Resource: Cluster Role Binding
resource "kubernetes_cluster_role_binding_v1" "eksdeveloper_clusterrolebinding" {
  metadata {
    name = "${var.project}-eksdeveloper-clusterrolebinding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.eksdeveloper_clusterrole.metadata.0.name
  }
  subject {
    kind      = "Group"
    name      = "eks-developer-group"
    api_group = "rbac.authorization.k8s.io"
  }
}