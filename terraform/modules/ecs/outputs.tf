output "ecs_cluster_id" {
  value = aws_ecs_cluster.my_cluster.id
}

output "ecs_task_arn" {
  value = aws_ecs_task_definition.app_task.arn
}

output "ecs_service_name" {
  value = aws_ecs_service.app_service.name
}