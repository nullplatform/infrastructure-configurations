resource "nullplatform_provider_config" "lambda" {
  provider = nullplatform
  nrn      = var.nrn
  type     = "aws-lambda-configuration"
  dimensions = {
    "env" : var.suffix
  }
  attributes = jsonencode({
    setup = {
      role_arn = var.Lambda_function_role_arn
    }
  })
}
