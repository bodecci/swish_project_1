# Reference Deployment YAML file
resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("${path.module}/../deployment.yaml"))

  # Ensure namespace is created first
  depends_on = [kubernetes_namespace.swish_proj]
}

# Reference Service YAML file
resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("${path.module}/../service.yaml"))

  # Ensure namespace is created first
  depends_on = [kubernetes_namespace.swish_proj]
}
