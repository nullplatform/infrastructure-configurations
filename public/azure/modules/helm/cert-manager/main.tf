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

# This might fail if we do not install nullplatform base chart, if so, reexecuting terraform after manual step might solve the issue
resource "helm_release" "cert-manager-config" {
  name = "${local.name}-config"

  repository       = "https://nullplatform.github.io/helm-charts"
  chart            = "nullplatform-${local.name}-config"
  create_namespace = true
  namespace        = local.namespace

  set {
    name  = "azure.subscriptionId"
    value = var.subscription_id
  }

  set {
    name  = "azure.resourceGroupName"
    value = var.resource_group_name
  }

  set {
    name  = "azure.clientId"
    value = var.client_id
  }

  set {
    name  = "hostedZoneName"
    value = var.domain_name
  }

}
