resource "nullplatform_provider_config" "docker_server" {
  nrn        = var.nrn
  type       = "docker-server"
  dimensions = {}
  attributes = jsonencode({
    "setup" : {
      "server" : var.login_server,
      "path" : "nullplatform",
      "username" : var.username,
      "password" : var.password,
      "use_namespace" : false
    },
    "repository_provider" : "docker_server"
  })
}
