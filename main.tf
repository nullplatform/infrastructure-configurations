# Conditional module loading
module "aws_module" {
  source = "./modules/aws"
  count = var.cloud_provider == "aws" ? 1 : 0
  providers = {
    aws = aws.default
    helm = helm.eks
    kubernetes = kubernetes.eks
    nullplatform = nullplatform.default
  }
  organization = var.organization
  account = var.account
  api_key = var.api_key
  domain_name = var.domain_name
}

module "azure_module" {
  source = "./modules/azure"
  count = var.cloud_provider == "azure" ? 1 : 0
}

module "google_module" {
  source = "./modules/google"
  count = var.cloud_provider == "google" ? 1 : 0
}
