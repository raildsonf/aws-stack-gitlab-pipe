terraform {
  backend "s3" {
    bucket = "centralized-tf-infra"
    key    = "apps/docker/hello/terraform.tfstate"
    region = "us-east-2"
  }
}