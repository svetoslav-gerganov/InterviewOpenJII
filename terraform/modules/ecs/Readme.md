# AWS ECS Terraform Module

This Terraform module provides a comprehensive setup for **AWS Elastic Container Service (ECS)**, including ECS clusters, task definitions, services, and required IAM roles. It is designed to deploy and manage containerized applications seamlessly using AWS Fargate.

## Features

- Creates an **ECS Cluster** to host containerized applications.
- Defines an **ECS Task Definition** for deploying containerized workloads.
- Configures an **ECS Service** to manage task instances and ensure high availability.
- Creates an **IAM Role** for ECS task execution with proper permissions.

## Module Components

1. **ECS Cluster** (`aws_ecs_cluster`):
   - Creates an ECS cluster for managing containerized workloads.

2. **ECS Task Definition** (`aws_ecs_task_definition`):
   - Specifies the configuration for running containers, including:
     - CPU and memory allocation
     - Network mode
     - Container definitions

3. **ECS Service** (`aws_ecs_service`):
   - Manages the lifecycle of tasks in the ECS cluster.
   - Supports Fargate launch type for serverless container management.
   - Configures load balancers for traffic routing.
   - Allows desired task count and network settings to be specified.

4. **IAM Role** (`aws_iam_role`):
   - Grants necessary permissions for ECS tasks to interact with other AWS services.

## Input Variables

The module accepts the following input variables for customization:
- `cluster_name`: Name of the ECS cluster.
- `task_family`: Family name of the task definition.
- `container_definitions`: JSON-formatted container definitions.
- `requires_compatibilities`: Compatibility mode for tasks (e.g., Fargate).
- `network_mode`: Networking mode for containers.
- `memory`: Task-level memory requirements.
- `cpu`: Task-level CPU requirements.
- `service_name`: Name of the ECS service.
- `desired_count`: Desired number of tasks to run.
- `target_group_arn`: ARN of the target group for load balancing.
- `container_port`: Port exposed by the container.
- `subnets`: Subnets for the ECS service.
- `security_groups`: Security groups for the ECS service.
- `assign_public_ip`: Whether to assign a public IP to the task.
- `app_name`: Application name used in naming resources.
- `environment`: Environment name (e.g., dev, staging, prod).

## Tags

All resources are tagged with:
- `Name`: Formatted as `"<app_name>-ecs-<resource>-<environment>"`.

## Example Usage

Here’s an example of how to use this module:

```hcl
module "ecs" {
  source                  = "./path-to-module"
  cluster_name            = "my-ecs-cluster"
  task_family             = "my-task-family"
  container_definitions   = jsonencode([
    {
      name      = "app-container"
      image     = "nginx"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  service_name             = "my-ecs-service"
  desired_count            = 2
  target_group_arn         = "arn:aws:elasticloadbalancing:..."
  container_port           = 80
  subnets                  = ["subnet-12345678", "subnet-87654321"]
  security_groups          = ["sg-12345678"]
  assign_public_ip         = true
  app_name                 = "my-app"
  environment              = "dev"
}