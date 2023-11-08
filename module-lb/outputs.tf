# Helm Release Outputs
output "lbc_controller_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.loadbalancer_controller.metadata
}