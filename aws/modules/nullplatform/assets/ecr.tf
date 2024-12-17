resource "nullplatform_provider_config" "ecr" {
  provider   = nullplatform
  nrn        = var.nrn
  type       = "ecr"
  dimensions = {}
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
  depends_on = [nullplatform_provider_config.aws]
}
