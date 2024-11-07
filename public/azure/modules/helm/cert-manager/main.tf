locals {
  name = "cert-manager"
}

resource "helm_release" "cert-manager" {
  name = local.name

  repository       = "https://charts.jetstack.io"
  chart            = local.name
  create_namespace = true
  namespace        = local.name

  set {
    name  = "crds.enabled"
    value = "true"
  }
}
