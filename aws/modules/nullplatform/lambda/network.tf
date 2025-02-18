module "network" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/provider/networking/vpc"

  nrn         = var.nrn
  environment = var.suffix

  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids


  private_load_balancer_arn          = var.private_load_balancer_arn
  private_load_balancer_listener_arn = var.private_load_balancer_listener_arn

  public_load_balancer_arn          = var.public_load_balancer_arn
  public_load_balancer_listener_arn = var.public_load_balancer_listener_arn
}
