module "aws" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/provider/cloud/aws"

  nrn         = var.nrn
  environment = var.suffix

  region                = var.region
  scope_manager_role    = var.scope_manager_role
  domain_name           = var.domain_name
  hosted_zone_id        = var.hosted_zone_id
  hosted_public_zone_id = var.hosted_public_zone_id
}
