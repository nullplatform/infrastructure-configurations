locals {
  policy = {
    "scope.capabilities.auto_scaling.instances.min_amount" : { "$gte" : 2 }
  }
}

resource "nullplatform_approval_policy" "environment" {
  name       = "allow_prod_asg_env"
  nrn        = var.nrn
  conditions = jsonencode(local.policy)
}

resource "nullplatform_approval_action" "environment" {
  nrn    = var.nrn
  entity = "scope"
  action = "scope:create"
  dimensions = {
    "env" = "production"
  }
  on_policy_success = "approve"
  on_policy_fail    = "manual"
  policies = [
    nullplatform_approval_policy.environment.id
  ]
}

resource "nullplatform_notification_channel" "slack_approvals" {
  nrn    = var.nrn
  type   = "slack"
  source = ["approval"]
  configuration {
    channels = ["test-approval"]
  }
}
