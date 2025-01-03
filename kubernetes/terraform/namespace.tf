resource "kubernetes_namespace" "swish_proj" {
  metadata {
    name = "swish-proj"
  }
}
