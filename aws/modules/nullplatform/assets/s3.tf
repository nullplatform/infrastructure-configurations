resource "nullplatform_provider_config" "s3" {
  provider   = nullplatform
  nrn        = var.nrn
  type       = "s3-configuration"
  dimensions = {}
  attributes = jsonencode({
    "bucket" : {
      "name" : var.lambda_assets_bucket
    }
  })
  depends_on = [ nullplatform_provider_config.aws ]
}
