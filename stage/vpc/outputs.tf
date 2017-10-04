output "subnetwork" {
  description = "Use this subnet when configuring your K8s instances"
  value = "${google_compute_subnetwork.default.name}"
}

output "network" {
  description = "The network name that gets created"
  value = "${google_compute_network.default.name}"
}
