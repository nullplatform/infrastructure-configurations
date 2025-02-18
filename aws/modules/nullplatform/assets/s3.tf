module "s3" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/provider/asset/s3"

  nrn                  = var.nrn
  lambda_assets_bucket = var.lambda_assets_bucket
}
