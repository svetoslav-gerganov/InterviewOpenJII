variable "cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
}

variable "task_family" {
  description = "Name of the ECS Task family"
  type        = string
}

variable "container_definitions" {
  description = "Container definitions in JSON format"
  type        = string
}

variable "requires_compatibilities" {
  description = "Required launch types"
  type        = list(string)
}

variable "network_mode" {
  description = "Network mode for ECS Task"
  type        = string
}

variable "memory" {
  description = "Memory for the ECS Task"
  type        = number
}

variable "cpu" {
  description = "CPU for the ECS Task"
  type        = number
}

variable "service_name" {
  description = "Name of the ECS Service"
  type        = string
}

variable "desired_count" {
  description = "Desired count of tasks in the ECS Service"
  type        = number
}

variable "target_group_arn" {
  description = "ARN of the ALB Target Group"
  type        = string
}

variable "container_port" {
  description = "Port for the container"
  type        = number
}

variable "subnets" {
  description = "Subnets for the ECS Service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Assign public IP to the ECS Service"
  type        = bool
}

variable "security_groups" {
  description = "Security groups for the ECS Service"
  type        = list(string)
}

variable "app_name" {
  description = "Application name for tagging"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type        = string
}