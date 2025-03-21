output "lb_sg_id" {
  value = aws_security_group.load_balancer_sg.id
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_service_sg.id
}
