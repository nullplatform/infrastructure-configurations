provider "nullplatform" {
  api_key = var.api_key
}

provider "aws" {
  region = "us-east-1"
  alias  = "stg"
}

provider "aws" {
  region = "us-east-1"
  alias  = "production"
}
