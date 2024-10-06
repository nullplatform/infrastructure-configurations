provider "nullplatform" {
  np_apikey = var.api_key
  alias = "default"
}

provider "aws" {
  region  = var.region
  alias   = "default"
}

provider "kubernetes" {
  alias                  = "eks"
  host                   = module.aws_module[0].cluster_endpoint
  cluster_ca_certificate = base64decode(module.aws_module[0].cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.aws_module[0].cluster_name]
  }
}

provider "helm" {
  alias = "eks"
  kubernetes {
    host                   = module.aws_module[0].cluster_endpoint
    cluster_ca_certificate = base64decode(module.aws_module[0].cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.aws_module[0].cluster_name]
      command     = "aws"
    }
  }
}
