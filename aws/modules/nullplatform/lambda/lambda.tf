module "lambda" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/provider/compute/lambda"

  nrn         = var.nrn
  environment = var.suffix

  lambda_function_role_arn = var.lambda_function_role_arn
}
