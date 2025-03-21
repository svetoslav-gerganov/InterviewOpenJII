variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the VPC and subnets"
  type        = string
}