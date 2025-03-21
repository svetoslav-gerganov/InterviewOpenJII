output "log_group_name" {
  value = aws_cloudwatch_log_group.app_log_group.name
}

output "cpu_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.cpu_utilization_alarm.arn
}

output "memory_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.memory_utilization_alarm.arn
}