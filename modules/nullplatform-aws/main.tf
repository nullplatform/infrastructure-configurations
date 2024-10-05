data "aws_caller_identity" "current" {}

resource "nullplatform_provider_config" "aws" {
  account       = var.account
  type          = "aws-configuration"
  dimensions    = {}
  attributes    = jsonencode({
    account = {
      id     = data.aws_caller_identity.current.account_id
      region = var.region
    }
    authentication = {
      application_manager_role              = var.application_manager_role
      application_manager_role_region       = var.region
      scope_manager_role                    = var.scope_manager_role
      telemetry_manager_role                = var.telemetry_manager_role
      build_workflow_user_access_key_id     = var.build_workflow_user_access_key_id
      build_workflow_user_secret_access_key = var.build_workflow_user_secret_access_key
      build_workflow_region                 = var.region
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
