resource "helm_release" "aks_config_helm" {
  name       = "nullplatform-k8s-helmchart"
  provider   = helm
  repository = "https://nullplatform.github.io/helm-charts"
  chart      = "nullplatform-chart"
  set {
    name  = "global.provider"
    value = "aks"
  }
  set {
    name  = "tls.secretName"
    value = var.tls_secret_name
  }
  set {
    name  = "istio.enabled"
    value = "true"
  }
  set {
    name  = "metricsServer.enabled"
    value = "false"
  }
  /*set {
    name  = "imagePullSecrets.enabled"
    value = tostring(var.image_pull_secrets_enabled)
  }
  set {
    name  = "imagePullSecrets.name"
    value = var.image_pull_secrets_name
  }
  set {
    name  = "imagePullSecrets.registry"
    value = var.image_pull_secrets_registry
  }
  set {
    name  = "imagePullSecrets.username"
    value = var.image_pull_secrets_username
  }
  set {
    name  = "imagePullSecrets.password"
    value = var.image_pull_secrets_password
  }*/
}
