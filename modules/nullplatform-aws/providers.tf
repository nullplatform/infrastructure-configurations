provider "aws" {
  region  = var.region
  alias   = "us-east-2"
}

provider "nullplatform" {
  np_apikey       = var.api_key
}
