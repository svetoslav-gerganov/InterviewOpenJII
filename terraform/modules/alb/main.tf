resource "aws_alb" "application_load_balancer" {
  name               = var.alb_name
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups
  tags = {
    Name = "${var.app_name}-alb-${var.environment}"
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  target_type = "ip"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.app_name}-alb-${var.environment}"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  tags = {
    Name = "${var.app_name}-alb-${var.environment}"
  }
}