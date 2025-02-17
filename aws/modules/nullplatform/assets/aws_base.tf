data "aws_caller_identity" "current" {
  provider = aws
}

# Cannot call the module as this one does not have dimensions
resource "nullplatform_provider_config" "aws" {
  provider   = nullplatform
  nrn        = var.nrn
  type       = "aws-configuration"
  dimensions = {}
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
