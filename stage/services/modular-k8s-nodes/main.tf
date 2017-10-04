provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

#configure remote state

terraform {
  backend "gcs" {
    bucket  = "glds-k8s-remote-state-stage"
    path    = "k8s_nodes_stage/terraform.tfstate"
    project = "glds-gcp"
  }
}

#Data source to retrieve network and subnet names

data "terraform_remote_state" "vpc" {
  backend   = "gcs"

  config {
    bucket  = "glds-k8s-remote-state-stage"
    path    = "vpc_stage/terraform.tfstate"
    project = "glds-gpc"
  }
}

#Create the VMs using GCE module

module "k8s" {
  source      = "github.com/GoogleCloudPlatform/terraform-google-k8s-gce"
  network     = "${data.terraform_remote_state.vpc.network}"
  subnetwork  = "${data.terraform_remote_state.vpc.subnetwork}"
  name        = "staging-cluster"
  k8s_version = "1.7.3"
  region      = "${var.region}"
  zone        = "us-west1-a"
  num_nodes   = "3"
  master_ip   = "10.240.0.10"
}
