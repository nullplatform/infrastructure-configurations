locals {
  name      = "cert-manager"
  namespace = "cert-manager"
}

resource "helm_release" "cert-manager" {
  name = local.name

  repository       = "https://charts.jetstack.io"
  chart            = local.name
  create_namespace = true
  namespace        = local.namespace

  set {
    name  = "crds.enabled"
    value = "true"
  }
}

# HACK: Created it here to avoid having to fail on the certificate
data "kubernetes_namespace" "gateways" {
  metadata {
    name = "gateways"
  }
}

resource "helm_release" "cert-manager-config" {
  name = "${local.name}-config"

  depends_on = [data.kubernetes_namespace.gateways]

  repository = path.module
  chart      = "cert-manager-config"
  namespace  = local.namespace

  set {
    name  = "subscriptionId"
    value = var.subscription_id
  }

  set {
    name  = "resourceGroupName"
    value = var.resource_group_name
  }

  set {
    name  = "hostedZoneName"
    value = var.domain_name
  }

  set {
    name  = "clientId"
    value = var.client_id
  }

}
