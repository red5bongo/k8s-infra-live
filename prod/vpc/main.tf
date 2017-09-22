provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
}

#create the VPC for the production environment

resource "google_compute_network" "default" {
  name	= "tf-k8s-production"
  description = "Network for K8s production environment"
}

# Create a subnet within the production VPC

resource "google_compute_subnetwork" "default" {
  description	= "default subnet for K8s servers"
  name 		= "k8s-subnet-prod"
  ip_cidr_range = "10.240.0.0/24"
  network 	= "${google_compute_network.default.self_link}"
  region	= "us-west1"
}


