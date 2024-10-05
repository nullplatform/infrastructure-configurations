resource "helm_release" "eks_config_helm" {
  name       = "nullplatform-k8s-helmchart"
  repository = "https://nullplatform.github.io/helm-charts/charts"
  chart      = "null-chart"

  set {
    name  = "global.provider"
    value = "eks"
  }

  set {
    name  = "global.awsRegion"
    value = var.region
  }

  set {
    name  = "tls.secretName"
    value = "www-tls"
  }

  set {
    name  = "cloudwatch.enabled"
    value = "true"
  }
}