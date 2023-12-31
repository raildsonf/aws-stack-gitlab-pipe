resource "aws_lb" "main" {
  name = "alb-${var.app}"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = var.subnet_ids
  tags = {
    App = var.app
  }
}

resource "aws_lb_target_group" "main" {
  name = "lb-tg-${var.app}"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc
}

resource "aws_lb_listener" "external-elb1" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"

    }
  }
}

resource "aws_lb_listener" "external-elb2" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}