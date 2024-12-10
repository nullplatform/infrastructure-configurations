locals {
  cluster_name = "${var.organization}-${var.account}-cluster"
}

################################################################################
# Meta Module
################################################################################

module "meta_stg" {
  source = "./modules/meta"
  providers = {
    aws = aws.stg
  }

  domain_name  = var.domain_name
  api_key      = var.api_key
  organization = var.organization
  account      = var.account
  nrn          = var.nrn
  namespace    = var.namespace
  vpc          = var.vpc_stg
  region       = "us-east-1"
  suffix       = "stg"

  nullplatform_role_arn                              = module.iam_roles_policies.nullplatform_role_arn
  nullplatform_scope_workflow_role_arn               = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
  nullplatform_telemetry_manager_role_arn            = module.iam_roles_policies.nullplatform_telemetry_manager_role_arn
  nullplatform_instance_profile_arn                  = module.iam_roles_policies.nullplatform_instance_profile_arn
  nullplatform_build_workflow_user_secret_access_key = module.iam_roles_policies.nullplatform_build_workflow_user_secret_access_key
  nullplatform_build_workflow_user_access_key_id     = module.iam_roles_policies.nullplatform_build_workflow_user_access_key_id
  nullplatform_application_role_arn                  = module.iam_roles_policies.nullplatform_application_role_arn
  nullplatform_dimensions                            = module.dimensions.ids

  hosted_zone_id        = module.route53.private_zone_id
  hosted_public_zone_id = module.route53.public_zone_id

  parameters_encryption = module.secret.parameters_encryption

}

module "meta_production" {
  source = "./modules/meta"
  providers = {
    aws = aws.production
  }

  domain_name  = var.domain_name
  api_key      = var.api_key
  organization = var.organization
  account      = var.account
  nrn          = var.nrn
  namespace    = var.namespace
  vpc          = var.vpc_production
  region       = "us-east-2"
  suffix       = "production"

  nullplatform_role_arn                              = module.iam_roles_policies.nullplatform_role_arn
  nullplatform_scope_workflow_role_arn               = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
  nullplatform_telemetry_manager_role_arn            = module.iam_roles_policies.nullplatform_telemetry_manager_role_arn
  nullplatform_instance_profile_arn                  = module.iam_roles_policies.nullplatform_instance_profile_arn
  nullplatform_build_workflow_user_secret_access_key = module.iam_roles_policies.nullplatform_build_workflow_user_secret_access_key
  nullplatform_build_workflow_user_access_key_id     = module.iam_roles_policies.nullplatform_build_workflow_user_access_key_id
  nullplatform_application_role_arn                  = module.iam_roles_policies.nullplatform_application_role_arn
  nullplatform_dimensions                            = module.dimensions.ids

  hosted_zone_id        = module.route53.private_zone_id
  hosted_public_zone_id = module.route53.public_zone_id

  parameters_encryption = module.secret.parameters_encryption

}

################################################################################
# Nullplatform Dimensions
################################################################################

module "dimensions" {
  source = "./modules/nullplatform/dimensions"

  nrn = var.nrn
}

################################################################################
# Secret Module
################################################################################

module "secret" {
  source = "./modules/secret"
}

################################################################################
# Route53 Module
################################################################################

module "route53" {
  source = "./modules/route53"
  providers = {
    aws = aws.stg
  }
  organization = var.organization
  account      = var.account
  domain_name  = var.domain_name
  vpcs = {
    "vpc_stg" = {
      vpc_id     = module.meta_stg.vpc_id
      vpc_region = "us-east-1"
    }
    "vpc_production" = {
      vpc_id     = module.meta_production.vpc_id
      vpc_region = "us-east-2"
    }
  }
}

################################################################################
# IAM ROLES & POLICIES Module
################################################################################

module "iam_roles_policies" {
  source = "./modules/iam-roles-policies"
  providers = {
    aws = aws.stg
  }

  organization               = var.organization
  account                    = var.account
  assets_bucket_arns         = [module.meta_stg.assets_bucket_arn, module.meta_production.assets_bucket_arn]
  parameters_bucket_arns     = [module.meta_stg.parameters_bucket_arn, module.meta_production.parameters_bucket_arn]
  parameters_encryption_arns = [module.secret.parameters_encryption_arn]
}
