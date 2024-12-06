locals {
  parameters_bucket = "null-parameters-${var.organization}-${var.account}-${var.namespace}"
  assets_bucket     = "null-assets-${var.organization}-${var.account}-${var.namespace}"
}

resource "aws_s3_bucket" "parameters-bucket" {
  bucket = local.parameters_bucket
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_s3_bucket" "assets-bucket" {
  bucket = local.assets_bucket
  tags = {
    organization = var.organization
    account      = var.account
  }
}
