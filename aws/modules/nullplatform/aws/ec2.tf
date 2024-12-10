resource "nullplatform_provider_config" "ec2" {
  provider   = nullplatform
  nrn        = var.nrn
  type       = "ec2-configuration"
  dimensions = {
    "env" : var.suffix
  }
  attributes = jsonencode({
    ami = {
      id = var.ec2_ami_id
    },
    storage = {
      parameters_bucket = var.ec2_parameters_bucket
      # parameters_encryption_secret = var.ec2_parameters_encryption_secret
    },
    security = {
      # ssh_key = var.ec2_ssh_key_name
      iam_profile = var.ec2_instance_profile

    }
  })
}
