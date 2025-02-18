locals {
  name   = "demo-cluster"
  region = "eu-west-1"
  tags = {
    cluster-name = local.name
    GithubRepo   = "terraform-aws-eks"
    GithubOrg    = "terraform-aws-modules"
  }
}