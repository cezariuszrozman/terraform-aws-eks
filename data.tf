data "aws_eks_cluster" "eks_al2" {
  depends_on = [module.eks_al2]
  name       = module.eks_al2.cluster_name
}

data "aws_eks_cluster_auth" "eks_al2" {
  depends_on = [module.eks_al2]
  name       = module.eks_al2.cluster_name
}
