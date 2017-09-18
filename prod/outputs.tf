output "ip_addresses" {
 value = "${google_compute_instance.default.*.network_interface.0.address}"
}

