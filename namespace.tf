resource "kubernetes_namespace" "example" {
  depends_on = [module.eks_al2]
  metadata {
    annotations = {
      name = "example-annotation"
    }

    labels = {
      mylabel = "label-value"
    }

    name = var.namespace
  }
}