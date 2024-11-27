# You can change this to your own bucket
terraform {
  backend "s3" {
    bucket         = "terraform-state-nullplatform-main"
    key            = "repos/infrastructure-configurations/pocs"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks-main"
    profile        = "null_runtime_main"
  }
}
