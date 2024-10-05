################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "./modules/vpc"

  region = var.region
}

################################################################################
# Route53 Module
################################################################################

module "route53" {
  source = "./modules/route53"

  region      = var.region
  domain_name = var.domain_name
  vpc_id      = module.vpc.vpc_id
}

################################################################################
# ACM Module
################################################################################

module "acm" {
  source = "./modules/acm"

  region      = var.region
  domain_name = var.domain_name
  zone_id     = module.route53.public_zone_id
}

################################################################################
# IAM ROLES & POLICIES Module
################################################################################

module "iam_roles_policies" {
  source = "./modules/iam-roles-policies"

  region = var.region
}

################################################################################
# EKS Cluster Module
################################################################################

module "eks" {
  source = "./modules/eks-cluster"

  region                 = var.region
  vpc_id                 = module.vpc.vpc_id
  private_subnets        = module.vpc.private_subnets
  scope_manager_role     = module.iam_roles_policies.null_scope_workflow_role_arn
  telemetry_manager_role = module.iam_roles_policies.null_telemetry_manager_role_arn
}

################################################################################
# EKS Cluster Configuration Module
################################################################################

module "eks_config" {
  source = "./modules/eks-config"

  region          = var.region
}

################################################################################
# AWS ALB Controller
################################################################################

module "aws_alb_controller" {
  source = "./modules/aws-alb-controller"

  region            = var.region
  env_name          = var.env_name
  cluster_name      = var.cluster_name
  vpc_id            = module.vpc.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn
}
