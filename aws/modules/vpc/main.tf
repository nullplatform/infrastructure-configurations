module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "nullplatform-vpc-${var.suffix}"
  cidr = var.vpc["cidr"]

  providers = {
    aws = aws
  }

  enable_dns_hostnames = true

  azs             = var.vpc["azs"]
  private_subnets = var.vpc["private_subnets"]
  public_subnets  = var.vpc["public_subnets"]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = {
    organization = var.organization
    account      = var.account
  }
}
