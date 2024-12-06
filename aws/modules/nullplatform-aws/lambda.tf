resource "nullplatform_provider_config" "lambda" {
  provider   = nullplatform
  nrn        = var.nrn
  type       = "aws-lambda-configuration"
  dimensions = {}
  attributes = jsonencode({
    function_role = {
      role = var.Lambda_function_role_arn
    }
  })
}
