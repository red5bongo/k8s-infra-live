output "instance_id" {
 value = "${google_compute_instance.default.self_link}"
}
output "instance_IP" {
 value = "${google_compute_address.default.default.network_interface.0.access_config.0.nat_ip}"
}
