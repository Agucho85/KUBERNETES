# Modulo que crea el addon de cni.
# Debe ser llamado por el root module despues de creado el eks y antes del child moudle de grupo de nodos privados, sino se deben reinicar los nodos creados por ese modulo.

# Crea el recurso del addon de cni dentro de aws, que lo replica en el eks. 
resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = "${var.project}-${var.cluster_name}"
  addon_name                  = "vpc-cni"
  addon_version               = "v1.14.1-eksbuild.1"
  resolve_conflicts_on_update = "PRESERVE"

  tags = {
    "eks_addon" = "vpc-cni"
  }

# Se realiza un local-exec dentro del eks, setando la configuracion del nodo para poder disponer de mas elastic-network-interfaces y con ello mas ips.
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${var.project}-${var.cluster_name} && kubectl set env daemonset aws-node -n kube-system ENABLE_PREFIX_DELEGATION=true && kubectl set env daemonset aws-node -n kube-system WARM_ENI_TARGET=3 && kubectl set env daemonset aws-node -n kube-system WARM_IP_TARGET=5"
  }
}
