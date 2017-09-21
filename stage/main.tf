provider "google" {
#  credentials = "${file("account.json")}"
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

module "node-minion" {
  source = "github.com/red5bongo/k8s-infra-modules//node-minion?ref=v0.0.1"

  node_count = 2
}

module "node-master" {
  source = "github.com/red5bongo/k8s-infra-modules//node-master?ref=v0.0.1"
}
