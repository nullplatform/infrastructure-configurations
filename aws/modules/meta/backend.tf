terraform {
  required_providers {
    nullplatform = {
      source = "nullplatform/nullplatform"
    }
    helm = {
      source = "hashicorp/helm"
    }
    aws = {
      source = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
