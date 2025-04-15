# ArgoCD Helm Chart deployment

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.8.26" # Specify the version you want to use
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  # Wait for the release to be deployed
  wait = true
  timeout = 600 # 10 minutes

  # Basic configuration values
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  # Configure high availability
  set {
    name  = "controller.replicas"
    value = "1"
  }

  set {
    name  = "server.replicas"
    value = "1"
  }

  set {
    name  = "repoServer.replicas"
    value = "1"
  }

  # Configure resource limits
  set {
    name  = "server.resources.limits.cpu"
    value = "300m"
  }

  set {
    name  = "server.resources.limits.memory"
    value = "512Mi"
  }

  set {
    name  = "server.resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "server.resources.requests.memory"
    value = "256Mi"
  }

  # Optional: Configure ingress
  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  # Optional: Configure ingress
  set {
    name  = "server.ingress.ingressClassName"
    value = "alb"
  }

  set {
    name   = "global.domain"
    value = "argocd.${var.domain}"
  }

  # Optional: Add values from a file for more complex configurations
  # values = [
  #   file("${path.module}/argocd-values.yaml")
  # ]

  depends_on = [
    # Add your EKS cluster dependency here, for example:
    module.eks_al2
  ]
}

# Optional: Output the ArgoCD server URL
# output "argocd_server_url" {
#   description = "URL of the ArgoCD server"
#   value       = resource.helm_release.argocd.status == "deployed" ? kubernetes_service.argocd_server_service.status.0.load_balancer.0.ingress.0.hostname : ""
#   depends_on  = [helm_release.argocd]
# }

# Optional: Create a Kubernetes Secret for the ArgoCD admin password
resource "random_password" "argocd_admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "kubernetes_secret" "argocd_admin_password" {
  metadata {
    name      = "argocd-admin-password"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  data = {
    password = random_password.argocd_admin_password.result
  }

  depends_on = [
    kubernetes_namespace.argocd
  ]
}

# Output the admin password
output "argocd_admin_password" {
  description = "ArgoCD admin password"
  value       = random_password.argocd_admin_password.result
  sensitive   = true
}

