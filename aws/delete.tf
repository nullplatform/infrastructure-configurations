# All this NEEDS TO BE DESTROYED

# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }
# }


# provider "helm" {
#   kubernetes {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#     }
#   }
# }

# module "eks" {
#   source = "./modules/eks-cluster"
#   providers = {
#     aws = aws.stg
#   }

#   cluster_name           = local.cluster_name
#   vpc_id                 = module.vpc.vpc_id
#   private_subnets        = module.vpc.private_subnets
#   scope_manager_role     = module.iam_roles_policies.nullplatform_scope_workflow_role_arn
#   telemetry_manager_role = module.iam_roles_policies.nullplatform_telemetry_manager_role_arn
#   organization           = var.organization
#   account                = var.account
# }

# module "vpc" {
#   source = "./modules/vpc"
#   providers = {
#     aws = aws.stg
#   }
#   organization = var.organization
#   account      = var.account
#   vpc          = var.vpc
# }
