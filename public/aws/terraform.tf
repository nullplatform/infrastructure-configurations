# You can change this to your own bucket
terraform {
  backend "s3" {
    bucket  = "bombo-terraform-nullplatform-stage"
    key     = "repos/infrastructure-configurations/pocs"
    region  = "us-east-1"
    profile = "bombo-nullplatform-stage"
  }
}
