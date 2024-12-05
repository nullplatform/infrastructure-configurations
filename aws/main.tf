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
# LB and SGs for EC2
################################################################################

module "alb" {
  source = "./modules/ec2-alb"
  providers = {
    aws = aws
  }

  certificate_arn    = module.acm.acm_certificate_arn
  public_subnet_ids  = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = var.vpc["cidr"]
}

################################################################################
# Buckets and Secret for objects
################################################################################

module "s3" {
  source = "./modules/s3-buckets"
  providers = {
    aws = aws
  }

  organization = var.organization
  account      = var.account
  namespace    = var.namespace
}

################################################################################
# IAM ROLES & POLICIES Module
################################################################################

module "iam_roles_policies" {
  source = "./modules/iam-roles-policies"
  providers = {
    aws = aws
  }

  organization              = var.organization
  account                   = var.account
  assets_bucket_arn         = module.s3.assets_bucket_arn
  parameters_bucket_arn     = module.s3.parameters_bucket_arn
  parameters_encryption_arn = module.s3.parameters_encryption_arn
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
  nrn                                   = var.nrn
  region                                = var.region
  cluster_name                          = local.cluster_name
  application_manager_role              = module.iam_roles_policies.nullplatform_application_role_arn
  scope_manager_role                    = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
  telemetry_manager_role                = module.iam_roles_policies.nullplatform_telemetry_manager_role_arn
  build_workflow_user_access_key_id     = module.iam_roles_policies.nullplatform_build_workflow_user_access_key_id
  build_workflow_user_secret_access_key = module.iam_roles_policies.nullplatform_build_workflow_user_secret_access_key

  domain_name           = var.domain_name
  hosted_zone_id        = module.route53.private_zone_id
  hosted_public_zone_id = module.route53.public_zone_id

  ec2_instance_profile             = module.iam_roles_policies.nullplatform_instance_profile_arn
  ec2_parameters_bucket            = module.s3.parameters_bucket
  ec2_parameters_encryption_secret = module.s3.parameters_encryption

  vpc_id                             = module.vpc.vpc_id
  subnet_ids                         = module.vpc.private_subnets
  security_group_ids                 = module.alb.security_group_ids
  private_load_balancer_arn          = module.alb.private_load_balancer_arn
  private_load_balancer_listener_arn = module.alb.private_load_balancer_listener_arn
  public_load_balancer_arn           = module.alb.public_load_balancer_arn
  public_load_balancer_listener_arn  = module.alb.public_load_balancer_listener_arn


  lambda_assets_bucket     = module.s3.assets_bucket
  Lambda_function_role_arn = module.iam_roles_policies.nullplatform_role_arn

}
