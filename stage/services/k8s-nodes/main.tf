provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
}

#configure remote state

terraform {
  backend "gcs" {
    bucket = "glds-k8s-remote-state-stage"
    path = "k8s_nodes_stage/terraform.tfstate"
    project = "glds-gcp"
  }
}

#Create the VMs

module "node-minion" {
  source = "github.com/red5bongo/k8s-infra-modules//node-minion"
#subnet name comes from VPC outputs file  
  subnetwork = "https://www.googleapis.com/compute/v1/projects/glds-gcp/regions/us-west1/subnetworks/k8s-subnet-stage"
  node_count = 2
}

module "node-master" {
  source = "github.com/red5bongo/k8s-infra-modules//node-master"

  subnetwork = "https://www.googleapis.com/compute/v1/projects/glds-gcp/regions/us-west1/subnetworks/k8s-subnet-stage"
}
