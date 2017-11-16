provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

#configure remote state

terraform {
  backend "gcs" {
    bucket  = "glds-k8s-remote-state-prod"
    path    = "k8s_prod/terraform.tfstate"
    project = "glds-gcp"
  }
}

#Data source to retrieve network and subnet names

data "terraform_remote_state" "vpc" {
  backend   = "gcs"
  config {
    bucket  = "glds-k8s-remote-state-prod"
    path    = "vpc_prod/terraform.tfstate"
    project = "glds-gpc"
  }
}

#Create the VMs using GCE module

module "k8s" {
  source      = "github.com/GoogleCloudPlatform/terraform-google-k8s-gce"
  network     = "${data.terraform_remote_state.vpc.network}"
  subnetwork  = "${data.terraform_remote_state.vpc.subnetwork}"
  name        = "${var.cluster_name}"
  k8s_version = "${var.k8s_version}"
  region      = "${var.region}"
  zone        = "${var.zone}"
  num_nodes   = "${var.cluster_size}"
  master_ip   = "${var.master_ip}"
  node_machine_type = "${var.machine_type}"
}