variable "app_name" {
  description = "Application name for tagging"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type        = string
}

variable "retention_in_days" {
  description = "Retention period for logs"
  type        = number
}

variable "evaluation_periods" {
  description = "Number of periods over which the alarm is evaluated"
  type        = number
}

variable "period" {
  description = "Period in seconds for each metric data point"
  type        = number
}

variable "cpu_threshold" {
  description = "CPU utilization threshold for the alarm"
  type        = number
}

variable "memory_threshold" {
  description = "Memory utilization threshold for the alarm"
  type        = number
}

variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS Service"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic for alarm actions"
  type        = string
}