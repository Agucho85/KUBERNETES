# EBS CSI Helm Release Outputs
output "ebs_csi_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.ebs_csi_driver.metadata
}

# Helm Release Outputs
output "cluster_autoscaler_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.cluster_autoscaler_release.metadata
}
