output "istio_egress" {
  description = "output needed to executed followin module"
  value = helm_release.istio_egress
}
output "istio_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.istio.metadata
}