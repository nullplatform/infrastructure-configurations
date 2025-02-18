locals {
  cluster_name = "${var.organization}-${var.account}-${var.suffix}"
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/aws/vpc"
  providers = {
    aws = aws
  }
  vpc    = var.vpc
  suffix = var.suffix
}

################################################################################
# LB and SGs for EC2
################################################################################

module "alb" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/aws/alb"
  providers = {
    aws = aws
  }
  certificate_arn    = var.acm_certificate_arn
  public_subnet_ids  = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = var.vpc["cidr"]
  suffix             = var.suffix
}

################################################################################
# EKS Cluster Module
################################################################################

module "eks" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/aws/eks"
  providers = {
    aws = aws
  }
  cluster_name           = local.cluster_name
  vpc_id                 = module.vpc.vpc_id
  private_subnets        = module.vpc.private_subnets
  scope_manager_role     = var.nullplatform_scope_workflow_role_arn
  telemetry_manager_role = var.nullplatform_telemetry_manager_role_arn
}

################################################################################
# EKS Cluster Configuration Module
################################################################################

module "eks_config" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/kubernetes/helm/nullplatform/aws"
}

################################################################################
# AWS ALB Controller
################################################################################

module "aws_alb_controller" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/kubernetes/helm/aws-alb-controller"
  providers = {
    aws        = aws
    kubernetes = kubernetes
  }
  cluster_name      = local.cluster_name
  vpc_id            = module.vpc.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn
  suffix            = var.suffix
}

################################################################################
# Nullplatform AWS Provider Configuration
################################################################################

module "nullplatform_configuration" {
  source = "../nullplatform/aws"
  providers = {
    aws = aws
  }

  api_key                               = var.api_key
  nrn                                   = var.nrn
  region                                = var.region
  cluster_name                          = local.cluster_name
  application_manager_role              = var.nullplatform_application_role_arn
  scope_manager_role                    = var.nullplatform_scope_workflow_role_arn
  telemetry_manager_role                = var.nullplatform_telemetry_manager_role_arn
  build_workflow_user_access_key_id     = var.nullplatform_build_workflow_user_access_key_id
  build_workflow_user_secret_access_key = var.nullplatform_build_workflow_user_secret_access_key

  domain_name           = var.domain_name
  hosted_zone_id        = var.hosted_zone_id
  hosted_public_zone_id = var.hosted_public_zone_id

  ec2_instance_profile             = var.nullplatform_instance_profile_arn
  ec2_parameters_bucket            = var.parameters_bucket
  ec2_parameters_encryption_secret = var.parameters_encryption

  vpc_id                             = module.vpc.vpc_id
  subnet_ids                         = module.vpc.private_subnets
  security_group_ids                 = module.alb.security_group_ids
  private_load_balancer_arn          = module.alb.private_load_balancer_arn
  private_load_balancer_listener_arn = module.alb.private_load_balancer_listener_arn
  public_load_balancer_arn           = module.alb.public_load_balancer_arn
  public_load_balancer_listener_arn  = module.alb.public_load_balancer_listener_arn

  lambda_function_role_arn = var.nullplatform_role_arn

  suffix = "poc${var.suffix}"

  depends_on = [var.nullplatform_dimensions]
}
