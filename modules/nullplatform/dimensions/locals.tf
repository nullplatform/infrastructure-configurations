locals {
  environments = [for env in ["development", "stg", "uat", "production"] : "poc${env}"]
}
