output "subnetwork" {
  description = "Use this subnet when configuring your K8s instances"
  value = "${google_compute_subnetwork.default.self_link}"
}
