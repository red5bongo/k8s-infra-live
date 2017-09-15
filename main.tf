provider "google" {
#  credentials = "${file("account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_instance" "default" {
  count = "${var.node_count}"
  name           = "terraform-node${count.index}"
  machine_type   = "g1-small"
  zone		 = "us-west1-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-1704-zesty-v20170811"
      }
  }
  network_interface {
    network = "default"
  }
}




