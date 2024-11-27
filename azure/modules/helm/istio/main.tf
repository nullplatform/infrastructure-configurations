locals {
  repository = "https://istio-release.storage.googleapis.com/charts"
  namespace  = "istio-system"
}
resource "helm_release" "istio_base" {
  name             = "istio-base"
  repository       = local.repository
  chart            = "base"
  namespace        = local.namespace
  create_namespace = true
}

resource "helm_release" "istiod" {
  name       = "istiod"
  depends_on = [helm_release.istio_base]
  repository = local.repository
  chart      = "istiod"
  namespace  = local.namespace
}

# Setup Istio Gateway using Helm
resource "helm_release" "istio_ingressgateway" {
  name       = "istio-ingressgateway"
  depends_on = [helm_release.istiod]
  repository = local.repository
  chart      = "gateway"
  namespace  = local.namespace

 set {
    name  = "platform"
    value = "demo"
  }
}
