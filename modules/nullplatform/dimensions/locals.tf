locals {
  environments = [for env in ["development", "stg", "uat", "production"] : "${env}"]
}
