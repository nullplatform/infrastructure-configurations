################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "./vpc"
  providers = {
    aws = aws
  }
  organization = var.organization
  account = var.account
}

################################################################################
# Route53 Module
################################################################################

module "route53" {
  source = "./route53"
  providers = {
    aws = aws
  }
  organization = var.organization
  account      = var.account
  domain_name  = var.domain_name
  vpc_id       = module.vpc.vpc_id
}

################################################################################
# ACM Module
################################################################################

module "acm" {
  source = "./acm"
  providers = {
    aws = aws
  }
  domain_name = var.domain_name
  zone_id     = module.route53.public_zone_id
  organization = var.organization
  account = var.account
}

################################################################################
# IAM ROLES & POLICIES Module
################################################################################

module "iam_roles_policies" {
  source = "./iam-roles-policies"
  providers = {
    aws = aws
  }
  organization = var.organization
  account = var.account
}

################################################################################
# EKS Cluster Module
################################################################################

module "eks" {
  source = "./eks-cluster"
  providers = {
    aws = aws
  }
  cluster_name           = var.cluster_name
  vpc_id                 = module.vpc.vpc_id
  private_subnets        = module.vpc.private_subnets
  scope_manager_role     = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
  telemetry_manager_role = module.iam_roles_policies.nullplatform_telemetry_manager_role_arn
  organization           = var.organization
  account                = var.account
}

################################################################################
# EKS Cluster Configuration Module
################################################################################

module "eks_config" {
  source = "./eks-config"
  providers = {
    aws = aws
  }
}

################################################################################
# AWS ALB Controller
################################################################################

module "aws_alb_controller" {
  source = "./aws-alb-controller"
  providers = {
    aws        = aws
    helm       = helm
    kubernetes = kubernetes
  }
  cluster_name      = var.cluster_name
  vpc_id            = module.vpc.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn
}

################################################################################
# Nullplatform AWS Provider Configuration
################################################################################

module "nullplatform_configuration" {
  source = "./nullplatform-aws"
  providers = {
    aws = aws
    nullplatform = nullplatform
  }
  api_key                               = var.api_key
  account                               = var.account
  region                                = var.region
  cluster_name                          = var.cluster_name
  application_manager_role              = module.iam_roles_policies.nullplatform_application_role_arn
  scope_manager_role                    = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
  telemetry_manager_role                = module.iam_roles_policies.nullplatform_telemetry_manager_role_arn
  build_workflow_user_access_key_id     = module.iam_roles_policies.nullplatform_build_workflow_user_access_key_id
  build_workflow_user_secret_access_key = module.iam_roles_policies.nullplatform_build_workflow_user_secret_access_key
}
