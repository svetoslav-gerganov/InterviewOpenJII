resource "aws_security_group" "load_balancer_sg" {
  name        = "${var.app_name}-lb-sg-${var.environment}"
  description = "Security group for the load balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-lb-sg-${var.environment}"
  }
}

resource "aws_security_group" "ecs_service_sg" {
  name        = "${var.app_name}-ecs-sg-${var.environment}"
  description = "Security group for the ECS service"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups  = [aws_security_group.load_balancer_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-ecs-sg-${var.environment}"
  }
}