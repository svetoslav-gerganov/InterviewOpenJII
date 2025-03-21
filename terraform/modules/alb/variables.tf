variable "alb_name" {
  description = "Name of the application load balancer"
  type        = string
  default = "alb"
}

variable "subnets" {
  description = "Subnets for the load balancer"
  type        = list(string)
  default = [ ]
}

variable "security_groups" {
  description = "Security groups for the load balancer"
  type        = list(string)
  default = [ ]
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
  default = "target-group"
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default = "HTTP"
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
  default = ""
}

variable "listener_port" {
  description = "Listener port for the load balancer"
  type        = number
  default = 0
}

variable "listener_protocol" {
  description = "Listener protocol for the load balancer"
  type        = string
  default = "HTTP"
}

variable "app_name" {
  description = "Application name for tagging"
  type        = string
  default = "OpenJII"
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type        = string
  default = "dev"
}