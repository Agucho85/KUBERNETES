# Modulo no esta termiando, no funciona todavia.
# Debe ser llamado por el root module despues de creado el modulo de grupo d enodos privados.

# resource "kubernetes_namespace" "istio-system" {
#   metadata {
#     annotations = {
#       name = "istio-namespace"
#     }

#     labels = {
#       mylabel   = "label-value"
#       ManagedBy = "Terraform"
#     }

#     name = "istio-namespace"
#   }
# }

resource "helm_release" "istio_base" {
  # name       = "istio-base"
  # depends_on = [kubernetes_namespace.istio-system]
  # chart      = "istio-1.18.1/manifests/charts/base"
  # namespace  = "istio-system"

  chart            = "base"
  namespace        = "istio-system"
  create_namespace = "true"
  name             = "istio-base"
  version          = "1.17.1"
  repository       = "http://github.com/istio/istio"

  set {
    name  = "grafana.enabled"
    value = "true"
  }

  set {
    name  = "grafana.security.adminPassword"
    value = "Passw0rd"
  }

  set {
    name  = "tracing.enabled"
    value = "true"
  }

  set {
    name  = "kiali.enabled"
    value = "true"
  }

  set {
    name  = "kiali.dashboard.grafana.usernameKey"
    value = "username"
  }

  set {
    name  = "kiali.dashboard.grafana.passphraseKey"
    value = "passphrase"
  }

  set {
    name  = "network-plugin"
    value = "cni"
  }
}

resource "helm_release" "istiod" {
  # name       = "istiod"
  # chart      = "istio-1.18.1/manifests/charts/istio-control/istio-discovery"
  # namespace  = "istio-system"
  # depends_on = [helm_release.istio_base]

  depends_on        = [helm_release.istio_base]
  name              = "istiod"
  namespace         = "istio-system"
  dependency_update = true
  repository        = "https://istio-release.storage.googleapis.com/charts"
  chart             = "istiod"
  version           = "1.18.1"
}

resource "helm_release" "istio_ingress" {
  # name       = "istio-ingress"
  # chart      = "istio-1.9.2/manifests/charts/gateways/istio-ingress"
  # namespace  = "istio-system"
  # depends_on = [helm_release.istiod]
  depends_on        = [helm_release.istiod]
  name              = "istio-ingress"
  namespace         = "istio-system"
  dependency_update = true
  repository        = "https://istio-release.storage.googleapis.com/charts"
  chart             = "istio-ingress"
  version           = "1.18.1"
}

resource "helm_release" "istio_egress" {
  # name       = "istio-egress"
  # chart      = "istio-1.9.2/manifests/charts/gateways/istio-egress"
  # namespace  = "istio-system"
  # depends_on = [helm_release.istio_ingress]
  depends_on        = [helm_release.istio_ingress]
  name              = "istio-egress"
  namespace         = "istio-system"
  dependency_update = true
  repository        = "https://istio-release.storage.googleapis.com/charts"
  chart             = "istio-egress"
  version           = "1.18.1"
}


# helm template istio-1.1.4/install/kubernetes/helm/istio --name istio --namespace istio-system  --set grafana.enabled=true --set tracing.enabled=true --set kiali.enabled=true --set kiali.dashboard.secretName=kiali --set kiali.dashboard.usernameKey=username --set kiali.dashboard.passphraseKey=passphrase | kubectl apply -f -

# kubectl rollout restart deployment istio-ingress -n istio-ingress
# kubectl get secrets/kiali -n istio-system --template={{.data.passphrase}} | base64 -D
# kubectl get secrets/grafana -n istio-system --template={{.data.passphrase}} | base64 -D