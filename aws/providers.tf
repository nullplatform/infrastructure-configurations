provider "nullplatform" {
  api_key = var.api_key
}

provider "aws" {
  region = "us-east-1"
  alias  = "stg"
}

provider "aws" {
  region = "us-east-2"
  alias  = "production"
}

# provider "kubernetes" {
#   alias                  = "stg"
#   host                   = module.meta_stg.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.meta_stg.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", module.meta_stg.cluster_name]
#   }
# }

# provider "kubernetes" {
#   alias                  = "production"
#   host                   = module.meta_production.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.meta_production.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", module.meta_production.cluster_name]
#   }
# }

# provider "helm" {
#   alias = "stg"
#   kubernetes {
#     host                   = module.meta_stg.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.meta_stg.cluster_certificate_authority_data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       args        = ["eks", "get-token", "--cluster-name", module.meta_stg.cluster_name]
#     }
#   }
# }

# provider "helm" {
#   alias = "production"
#   kubernetes {
#     host                   = module.meta_production.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.meta_production.cluster_certificate_authority_data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       args        = ["eks", "get-token", "--cluster-name", module.meta_production.cluster_name]
#     }
#   }
# }
