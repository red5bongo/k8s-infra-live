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

#Create the VMs

module "k8s" {
  source      = "github.com/GoogleCloudPlatform/terraform-google-k8s-gce"
  network     = "tf-k8s-staging"
  subnetwork  = "k8s-subnet-stage"
  name        = "k8s-staging"
  k8s_version = "1.7.3"
  region      = "${var.region}"
  zone        = "us-west1-a"
  num_nodes   = "3"
  master_ip   = "10.240.0.10"
}
