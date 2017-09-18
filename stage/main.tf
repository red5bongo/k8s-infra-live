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
  source = "/home/vagrant/k8s-terraform/k8s-infra-modules/node-minion"

  node_count = 2

}
