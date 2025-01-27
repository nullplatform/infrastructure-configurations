resource "nullplatform_provider_config" "azure" {
  nrn        = try(regex("(.*):namespace.*", var.nrn)[0], var.nrn)
  type       = "github-configuration"
  dimensions = {}
  attributes = jsonencode({
    "setup" : {
      "organization" : var.github_organization,
      "installation_id" : var.github_organization_installation_id,
    },
    }
  )
}

