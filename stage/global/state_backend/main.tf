provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_storage_bucket" "remote_state" {
  name 		= "glds-k8s-remote-state-stage"
  storage_class	= "REGIONAL" 
  location	= "${var.region}" 
}
