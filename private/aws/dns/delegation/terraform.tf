terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "nullplatform-clients-state"
    key     = "clients/${var.organization}/repo/infrastructure-configurations/dns"
    region  = "us-east-1"
    profile = "null_runtime_main"
  }
}
