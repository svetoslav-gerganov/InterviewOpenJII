variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "app_name" {
  description = "The name of the application"
  type        = string
  default     = "OpenJII"
}

variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "docker_image" {
  description = "Docker image to deploy"
  type        = string
  default     = "sgerganov1/node-jii-app:latest"
}

# variable "sns_topic_arn" {
#   description = "ARN of SNS Topic for CloudWatch Alarms"
#   type        = string
#   default = ""
# }

# variable "subnets" {
#   description = "List of subnet IDs"
#   type        = list(string)
#   default     = []
# }

###############

# variable "app_name" {
#   description = "Application name for tagging"
#   type        = string
# }

# variable "environment" {
#   description = "Environment name (e.g., dev, prod)"
#   type        = string
# }

# variable "aws_region" {
#   description = "AWS region to deploy resources"
#   type        = string
# }