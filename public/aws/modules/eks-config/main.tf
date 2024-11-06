data "aws_region" "current" {
  provider = aws
}

resource "helm_release" "eks_config_helm" {
  name       = "nullplatform-k8s-helmchart"
  provider   = helm
  repository = "https://nullplatform.github.io/helm-charts"
  chart      = "nullplatform-chart"
  set {
    name  = "global.provider"
    value = "eks"
  }
  set {
    name  = "global.awsRegion"
    value = data.aws_region.current.name
  }
  set {
    name  = "tls.secretName"
    value = var.tls_secret_name
  }
  set {
    name  = "cloudwatch.enabled"
    value = tostring(var.cloudwatch_enabled)
  }
}
