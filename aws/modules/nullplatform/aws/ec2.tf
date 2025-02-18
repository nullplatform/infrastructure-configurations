module "ec2" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/provider/compute/ec2"

  nrn         = var.nrn
  environment = var.suffix

  ami_id           = var.ec2_ami_id
  instance_profile = var.ec2_instance_profile

  parameters_bucket            = var.ec2_parameters_bucket
  parameters_encryption_secret = var.ec2_parameters_encryption_secret
}
