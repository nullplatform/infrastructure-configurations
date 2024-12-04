terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
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
        encrypt = true
    }
}
