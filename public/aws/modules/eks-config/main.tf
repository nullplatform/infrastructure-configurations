data "aws_region" "current" {
  provider = aws
}

resource "helm_release" "eks_config_helm" {
  name       = "nullplatform-base"
  provider   = helm
  repository = "https://nullplatform.github.io/helm-charts"
  chart      = "nullplatform-base"
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
