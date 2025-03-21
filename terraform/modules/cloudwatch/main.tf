resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/ecs/${var.app_name}-${var.environment}-logs"
  retention_in_days = var.retention_in_days
  tags = {
    Name = "${var.app_name}-${var.environment}-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "app_log_stream" {
  name           = "${var.app_name}-${var.environment}-log-stream"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
  
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "${var.app_name}-${var.environment}-cpu-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.period
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Alarm when CPU utilization exceeds ${var.cpu_threshold}%"
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = [var.sns_topic_arn]

  tags = {
    Name = "${var.app_name}-${var.environment}-cpu-utilization-alarm"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_utilization_alarm" {
  alarm_name          = "${var.app_name}-${var.environment}-memory-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.period
  statistic           = "Average"
  threshold           = var.memory_threshold
  alarm_description   = "Alarm when memory utilization exceeds ${var.memory_threshold}%"
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = [var.sns_topic_arn]

  tags = {
    Name = "${var.app_name}-${var.environment}-memory-utilization-alarm"
  }
}