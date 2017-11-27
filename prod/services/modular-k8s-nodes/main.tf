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
  source      = "git::https://github.com/GoogleCloudPlatform/terraform-google-k8s-gce?ref=1.0.0"
  network     = "${data.terraform_remote_state.vpc.network}"
  subnetwork  = "${data.terraform_remote_state.vpc.subnetwork}"
  name        = "prod"
  k8s_version = "1.7.3"
  region      = "${var.region}"
  zone        = "us-west1-a"
  num_nodes   = "4"
  master_ip   = "10.240.0.10"
  node_machine_type = "n1-standard-4"
}
