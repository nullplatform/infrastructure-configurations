resource "nullplatform_provider_config" "aws" {
  account       = var.account
  type          = "aws-configuration"
  dimensions    = {}
  attributes    = jsonencode({
    account = {
      id     = ""
      region = ""
    }
    networking = {
      public_dns_zone_id  = "mock-public-zone",
      private_dns_zone_id = "mock-private-zone"
    },
    authentication = {
      credential_base_64 = "bW9jay1iYXNlNjQtZW5jb2RlZC1jcmVkZW50aWFsLWpzb24="
    }
  })
}

resource "nullplatform_provider_config" "eks" {
  account      = var.account
  type         = "eks-configuration"
  dimensions   = {}
  attributes = jsonencode({
    cluster = {
      id        = var.cluster_name,
      namespace = "nullplatform"
    },
    web_pool_provider = "AWS:WEB_POOL:EKS"
  })
  depends_on = [
    nullplatform_provider_config.aws 
  ]
}