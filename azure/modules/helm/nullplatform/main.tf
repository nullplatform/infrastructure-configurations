resource "helm_release" "config_helm" {
  name                       = "nullplatform-base"
  provider                   = helm
  repository                 = "https://nullplatform.github.io/helm-charts"
  chart                      = "nullplatform-base"
  namespace                  = "default"
  disable_openapi_validation = true
  set {
    name  = "global.provider"
    value = "aks"
  }
  set {
    name  = "metricsServer.enabled"
    value = false
  }
}
