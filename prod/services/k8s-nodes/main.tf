provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
}

#configure remote state

terraform {
  backend "gcs" {
    bucket = "glds-k8s-remote-state-prod"
    path = "k8s-nodes-prod/terraform.tfstate"
    project = "glds-gcp"
  }
}

module "node-minion" {
  source = "/home/vagrant/k8s-terraform/k8s-infra-modules/node-minion"

  node_count = 5
  subnetwork = "https://www.googleapis.com/compute/v1/projects/glds-gcp/regions/us-west1/subnetworks/k8s-subnet-prod"
}

module "node-master" {
  source = "/home/vagrant/k8s-terraform/k8s-infra-modules/node-master"
  subnetwork = "https://www.googleapis.com/compute/v1/projects/glds-gcp/regions/us-west1/subnetworks/k8s-subnet-prod"
}




