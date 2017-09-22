provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket = "glds-terraform-remote-state-storage"
    path = "k8s-infra-live-stage/terraform.tfstate"
    project = "glds-gcp"
  }
}

#Network section
resource "google_compute_network" "default" {
  name	= "tf-k8s-staging"
  description = "Network for K8s staging environment"
}

resource "google_compute_subnetwork" "default" {
  description	= "default subnet for K8s servers"
  name 		= "k8s-subnet"
  ip_cidr_range = "10.240.0.0/24"
  network 	= "${google_compute_network.default.self_link}"
  region	= "us-west1"
}

#Create the VMs

module "node-minion" {
  source = "github.com/red5bongo/k8s-infra-modules//node-minion"
#subnet name comes from VPC outputs file  
  subnetwork = "https://www.googleapis.com/compute/v1/projects/glds-gcp/regions/us-west1/subnetworks/k8s-subnet-stage"
  node_count = 2
}

#module "node-master" {
#  source = "github.com/red5bongo/k8s-infra-modules//node-master"
#
#  subnetwork = "${google_compute_subnetwork.default.self-link}"
#}
