variable "app_name" {
  description = "Application name for tagging"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security groups"
  type        = string
}