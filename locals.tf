locals {
  name   = "czarus"
  region = "eu-west-1"
  tags = {
    cluster-name = local.name
    GithubRepo   = "terraform-aws-eks"
    GithubOrg    = "terraform-aws-modules"
  }
}