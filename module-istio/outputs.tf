output "istio_egress" {
  description = "output needed to executed followin module"
  value = helm_release.istio_egress
}