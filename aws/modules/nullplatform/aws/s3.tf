resource "nullplatform_provider_config" "s3" {
  provider   = nullplatform
  nrn        = var.nrn
  type       = "s3-configuration"
  dimensions = {
    "env" : var.suffix
  }
  attributes = jsonencode({
    "bucket" : {
      "name" : var.lambda_assets_bucket
    }
  })
}
