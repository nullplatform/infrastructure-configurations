resource "aws_security_group" "null-main-balancer" {
  vpc_id = var.vpc_id

  tags = {
    Name = "load_balancer"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_lb_https" {
  security_group_id = aws_security_group.null-main-balancer.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_lb_http" {
  security_group_id = aws_security_group.null-main-balancer.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_lb_all" {
  security_group_id = aws_security_group.null-main-balancer.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = -1
  to_port     = -1
}

resource "aws_security_group" "http-instance" {
  vpc_id = var.vpc_id

  //If you do not add this rule, you can not reach the NGIX
  tags = {
    Name = "http-instance"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_instance_http" {
  security_group_id            = aws_security_group.http-instance.id
  referenced_security_group_id = aws_security_group.null-main-balancer.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_instance_http_default_null" {
  security_group_id            = aws_security_group.http-instance.id
  cidr_ipv4  = var.vpc_cidr
  from_port                    = 8080
  ip_protocol                  = "tcp"
  to_port                      = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow_instance_ssh" {
  security_group_id = aws_security_group.http-instance.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_instance_all" {
  security_group_id = aws_security_group.http-instance.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = -1
  to_port     = -1
}

