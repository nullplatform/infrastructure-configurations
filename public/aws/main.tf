locals {
  cluster_name = "${var.organization}-${var.account}-cluster"
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws
  }
  organization = var.organization
  account      = var.account
  vpc          = var.vpc
}

################################################################################
# Route53 Module
################################################################################

module "route53" {
  source = "./modules/route53"
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
  source = "./modules/acm"
  providers = {
    aws = aws
  }
  domain_name  = var.domain_name
  zone_id      = module.route53.public_zone_id
  organization = var.organization
  account      = var.account
}

################################################################################
# IAM ROLES & POLICIES Module
################################################################################

module "iam_roles_policies" {
  source = "./modules/iam-roles-policies"
  providers = {
    aws = aws
  }
  organization = var.organization
  account      = var.account
}

################################################################################
# EKS Cluster Module
################################################################################

module "eks" {
  source = "./modules/eks-cluster"
  providers = {
    aws = aws
  }
  cluster_name           = local.cluster_name
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
  source = "./modules/eks-config"
  providers = {
    aws = aws
  }
}

################################################################################
# AWS ALB Controller
################################################################################

module "aws_alb_controller" {
  source = "./modules/aws-alb-controller"
  providers = {
    aws        = aws
    helm       = helm
    kubernetes = kubernetes
  }
  cluster_name      = local.cluster_name
  vpc_id            = module.vpc.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn
}

################################################################################
# Nullplatform AWS Provider Configuration
################################################################################

module "nullplatform_configuration" {
  source = "./modules/nullplatform-aws"
  providers = {
    aws          = aws
    nullplatform = nullplatform
  }
  api_key                               = var.api_key
  account                               = var.account
  region                                = var.region
  cluster_name                          = local.cluster_name
  application_manager_role              = module.iam_roles_policies.nullplatform_application_role_arn
  scope_manager_role                    = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
  telemetry_manager_role                = module.iam_roles_policies.nullplatform_telemetry_manager_role_arn
  build_workflow_user_access_key_id     = module.iam_roles_policies.nullplatform_build_workflow_user_access_key_id
  build_workflow_user_secret_access_key = module.iam_roles_policies.nullplatform_build_workflow_user_secret_access_key
}
