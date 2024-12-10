data "aws_caller_identity" "current" {
  provider = aws
}

resource "nullplatform_provider_config" "aws" {
  provider   = nullplatform
  nrn        = var.nrn
  type       = "aws-configuration"
  dimensions = {
    "env" : var.suffix
  }
  attributes = jsonencode({
    iam = {
      scope_workflow_role = var.scope_manager_role
    }
    account = {
      id     = data.aws_caller_identity.current.account_id
      region = var.region
    }
    networking = {
      application_domain    = true
      domain_name           = var.domain_name
      hosted_zone_id        = var.hosted_zone_id
      hosted_public_zone_id = var.hosted_public_zone_id
    }
  })
}

resource "nullplatform_provider_config" "eks" {
  provider = nullplatform
  nrn      = var.nrn
  type     = "eks-configuration"
  dimensions = {
    "env" : var.suffix
  }
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


resource "nullplatform_provider_config" "ecr" {
  provider   = nullplatform
  nrn        = var.nrn
  type       = "ecr"
  dimensions = {
    "env" : var.suffix
  }
  attributes = jsonencode({
    "ci" : {
      "region" : var.region,
      "access_key" : var.build_workflow_user_access_key_id
      "secret_key" : var.build_workflow_user_secret_access_key
    },
    "setup" : {
      "region" : var.region,
      "role_arn" : var.application_manager_role
    }
  })
}
