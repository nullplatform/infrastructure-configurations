terraform {
  backend "s3" {
    bucket = "tofu-state-bucket-test-david"
    key    = "repo//infrastructure-configurations/aws"
    region = "us-east-1"
  }
}
