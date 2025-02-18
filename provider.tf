provider "aws" {
  region = local.region
}
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks_al2.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.eks_al2.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_al2.certificate_authority[0].data)
}

provider "helm" {
  kubernetes {
    host                   = module.eks_al2.cluster_endpoint
    token                  = data.aws_eks_cluster_auth.eks_al2.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_al2.certificate_authority[0].data)
  }
}