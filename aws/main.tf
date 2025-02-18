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
  parameters_bucket     = module.bucket_parameters.bucket_id

  acm_certificate_arn = module.acm.acm_certificate_arn

}

# module "meta_production" {
#   source = "./modules/meta"
#   providers = {
#     aws = aws.production
#   }

#   domain_name  = var.domain_name
#   api_key      = var.api_key
#   organization = var.organization
#   account      = var.account
#   nrn          = var.nrn
#   namespace    = var.namespace
#   vpc          = var.vpc_production
#   region       = "us-east-1"
#   suffix       = "production"

#   nullplatform_role_arn                              = module.iam_roles_policies.nullplatform_role_arn
#   nullplatform_scope_workflow_role_arn               = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
#   nullplatform_telemetry_manager_role_arn            = module.iam_roles_policies.nullplatform_telemetry_manager_role_arn
#   nullplatform_instance_profile_arn                  = module.iam_roles_policies.nullplatform_instance_profile_arn
#   nullplatform_build_workflow_user_secret_access_key = module.iam_roles_policies.nullplatform_build_workflow_user_secret_access_key
#   nullplatform_build_workflow_user_access_key_id     = module.iam_roles_policies.nullplatform_build_workflow_user_access_key_id
#   nullplatform_application_role_arn                  = module.iam_roles_policies.nullplatform_application_role_arn
#   nullplatform_dimensions                            = module.dimensions.ids

#   hosted_zone_id        = module.route53.private_zone_id
#   hosted_public_zone_id = module.route53.public_zone_id

#   parameters_encryption = module.secret.parameters_encryption
#   parameters_bucket     = module.s3.parameters_bucket
#   parameters_encryption = module.secret.parameters_encryption

#   acm_certificate_arn = module.acm.acm_certificate_arn
# }

################################################################################
# Github Module
################################################################################

module "code-repository" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/provider/code/github"
  nrn    = var.nrn

  organization                 = var.github_organization
  organization_installation_id = var.github_organization_installation_id
}

################################################################################
# ACM Module
################################################################################

module "acm" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/aws/acm"
  providers = {
    aws = aws
  }
  domain_name  = var.domain_name
  zone_id      = module.route53.public_zone_id
  organization = var.organization
  account      = var.account
}

################################################################################
# Nullplatform Dimensions
################################################################################

module "dimensions" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/dimensions"

  nrn = var.nrn
}

################################################################################
# Nullplatform Lambda
################################################################################

module "null_lambda_dev" {
  source = "./modules/nullplatform/lambda"

  domain_name = var.domain_name
  api_key     = var.api_key
  nrn         = var.nrn
  region      = "us-east-1"
  suffix      = "pocdevelopment"

  lambda_function_role_arn = module.iam_roles_policies.nullplatform_role_arn

  scope_manager_role       = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
  application_manager_role = module.iam_roles_policies.nullplatform_application_role_arn

  hosted_zone_id        = module.route53.private_zone_id
  hosted_public_zone_id = module.route53.public_zone_id

  vpc_id             = module.meta_stg.vpc_id
  subnet_ids         = module.meta_stg.subnet_ids
  security_group_ids = module.meta_stg.security_group_ids

  private_load_balancer_arn          = module.meta_stg.private_load_balancer_arn
  private_load_balancer_listener_arn = module.meta_stg.private_load_balancer_listener_arn
  public_load_balancer_arn           = module.meta_stg.public_load_balancer_arn
  public_load_balancer_listener_arn  = module.meta_stg.public_load_balancer_listener_arn
}

################################################################################
# Buckets and for objects
################################################################################

module "bucket_parameters" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/aws/bucket"
  providers = {
    aws = aws
  }
  name = "nullplatform-${var.organization}-${var.account}-parameters"
}

module "bucket_assets" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/aws/bucket"
  providers = {
    aws = aws
  }
  name = "nullplatform-${var.organization}-${var.account}-assets"
}

module "assets" {
  source = "./modules/nullplatform/assets"

  api_key = var.api_key
  nrn     = var.nrn
  region  = "us-east-1"

  application_manager_role              = module.iam_roles_policies.nullplatform_application_role_arn
  build_workflow_user_access_key_id     = module.iam_roles_policies.nullplatform_build_workflow_user_access_key_id
  build_workflow_user_secret_access_key = module.iam_roles_policies.nullplatform_build_workflow_user_secret_access_key
  scope_manager_role                    = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
  lambda_assets_bucket                  = module.bucket_assets.bucket_id

  domain_name           = var.domain_name
  hosted_public_zone_id = module.route53.public_zone_id
  hosted_zone_id        = module.route53.private_zone_id
}

################################################################################
# Secret Module for params
################################################################################

module "secret" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/aws/secret"
  providers = {
    aws = aws
  }
  name = "nullplatform-${var.organization}-${var.account}"
}

################################################################################
# Route53 Module
################################################################################

module "route53" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/aws/route53"
  providers = {
    aws = aws.stg
  }
  domain_name = var.domain_name
  vpcs = {
    "vpc_stg" = {
      vpc_id     = module.meta_stg.vpc_id
      vpc_region = "us-east-1"
    }
    # "vpc_production" = {
    #   vpc_id     = module.meta_production.vpc_id
    #   vpc_region = "us-east-1"
    # }
  }
}

################################################################################
# IAM ROLES & POLICIES Module
################################################################################

module "iam_roles_policies" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/aws/iam/roles/nullplatform"
  providers = {
    aws = aws.stg
  }

  assets_bucket_arns         = [module.bucket_assets.bucket_arn]
  parameters_bucket_arns     = [module.bucket_parameters.bucket_arn]
  parameters_encryption_arns = [module.secret.parameters_encryption_arn]
}
