resource "aws_lb" "null-main-balancer" {
  name               = "null-main-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.null-main-balancer.id]
  subnets            = var.public_subnet_ids
}


resource "aws_lb_target_group" "default_target_group" {
  name     = "default-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path     = "/health"
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "null-main-listener-http" {
  load_balancer_arn = aws_lb.null-main-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_target_group.arn
  }
}

resource "aws_lb_listener" "null-main-listener-https" {
  load_balancer_arn = aws_lb.null-main-balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_target_group.arn
  }
}

resource "aws_lb" "null-main-balancer-internal" {
  name               = "null-main-balancer-internal"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.null-main-balancer.id]
  subnets            = var.private_subnet_ids
}
resource "aws_lb_listener" "null-main-internal-listener-https" {
  load_balancer_arn = aws_lb.null-main-balancer-internal.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_target_group_internal.arn
  }
}

resource "aws_lb_target_group" "default_target_group_internal" {
  name     = "default-internal-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path     = "/health"
    protocol = "HTTP"
  }
}

