# locals {
#   # policy = {
#   #   "scope.capabilities.auto_scaling.instances.min_amount" : { "$gte" : 2 }
#   # }
#   policy = {
#     "scope.type" : { "$eq" : "serverless" }
#   }
# }

# resource "nullplatform_approval_policy" "policy" {
#   name       = "development_only_lambda"
#   nrn        = var.nrn
#   conditions = jsonencode(local.policy)
# }

# resource "nullplatform_approval_action" "action" {
#   nrn    = var.nrn
#   entity = "scope"
#   action = "scope:create"
#   dimensions = {
#     "env" = "development"
#   }
#   on_policy_success = "approve"
#   on_policy_fail    = "manual"
#   policies = [
#     nullplatform_approval_policy.policy.id
#   ]
# }

# resource "nullplatform_notification_channel" "slack_approvals" {
#   nrn    = var.nrn
#   type   = "slack"
#   source = ["approval"]
#   configuration {
#     channels = ["femsa-nullplatform"]
#   }
# }
