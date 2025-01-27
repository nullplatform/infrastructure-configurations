terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    nullplatform = {
      source = "nullplatform/nullplatform"
    }
  }

  backend "s3" {
    bucket         = "nullplatform-clients-state"                                                  # Replace with your S3 bucket name
    key            = "clients/movistar/repo/infrastructure-configurations/azure/terraform.tfstate" # Replace with the path and file name for your state file
    region         = "us-east-1"                                                                   # Replace with your AWS region
    dynamodb_table = "terraform-up-and-running-locks-main"
    profile        = "null_runtime_main"
  }
}
