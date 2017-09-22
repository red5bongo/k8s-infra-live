provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket = "glds-terraform-remote-state-storage"
    path = "k8s-infra-live-prod/terraform.tfstate"
    project = "glds-gcp"
  }
}

module "node-minion" {
  source = "/home/vagrant/k8s-terraform/k8s-infra-modules/node-minion"

  node_count = 5

}

module "node-master" {
  source = "/home/vagrant/k8s-terraform/k8s-infra-modules/node-master"
}




