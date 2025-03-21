# AWS CloudWatch Monitoring Terraform Module

This Terraform module simplifies the setup of **AWS CloudWatch** monitoring for ECS services by creating log groups, log streams, and metric alarms. It is designed to provide robust monitoring and alerting for critical ECS metrics like CPU and memory utilization.

## Features

- Creates a **CloudWatch Log Group** for ECS application logs with configurable retention periods.
- Sets up a **Log Stream** for storing log events in the log group.
- Configures **Metric Alarms** for CPU and memory utilization with SNS notification support.

## Module Components

The module includes the following resources:
1. **CloudWatch Log Group** (`aws_cloudwatch_log_group`):
   - Organizes logs for ECS services.
   - Retention period is configurable to suit compliance and cost management needs.

2. **CloudWatch Log Stream** (`aws_cloudwatch_log_stream`):
   - Enables log streams within the created log group.

3. **CPU Utilization Metric Alarm** (`aws_cloudwatch_metric_alarm`):
   - Monitors ECS service CPU usage and triggers an alarm if it exceeds a defined threshold.
   - Configurable evaluation periods, thresholds, and SNS notifications.

4. **Memory Utilization Metric Alarm** (`aws_cloudwatch_metric_alarm`):
   - Monitors ECS service memory usage and triggers an alarm if it exceeds a defined threshold.
   - Configurable evaluation periods, thresholds, and SNS notifications.

## Input Variables

This module accepts the following input variables for customization:
- `app_name`: Application name used in naming resources.
- `environment`: Environment name (e.g., dev, staging, prod).
- `retention_in_days`: Log retention period in days.
- `evaluation_periods`: Number of periods for evaluating the alarm condition.
- `period`: The period (in seconds) over which the specified statistic is applied.
- `cpu_threshold`: CPU usage threshold for triggering the alarm.
- `memory_threshold`: Memory usage threshold for triggering the alarm.
- `ecs_cluster_name`: ECS cluster name for the alarm dimensions.
- `ecs_service_name`: ECS service name for the alarm dimensions.
- `sns_topic_arn`: SNS topic ARN for alarm notifications.

## Tags

The module applies consistent tagging to all resources:
- Resources are tagged with `Name` in the format: `"<app_name>-<environment>-<resource-type>"`.

## Example Usage

Here’s an example of how to use this module:

```hcl
module "cloudwatch" {
  source               = "./path-to-module"
  app_name             = "my-app"
  environment          = "dev"
  retention_in_days    = 30
  evaluation_periods   = 3
  period               = 300
  cpu_threshold        = 80
  memory_threshold     = 75
  ecs_cluster_name     = "my-ecs-cluster"
  ecs_service_name     = "my-ecs-service"
  sns_topic_arn        = "arn:aws:sns:region:account-id:topic-name"
}