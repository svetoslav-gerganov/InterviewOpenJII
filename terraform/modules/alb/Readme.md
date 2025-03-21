# AWS Application Load Balancer (ALB) Terraform Module

This Terraform module is designed to deploy and configure an **AWS Application Load Balancer (ALB)** along with its associated target group and listener. It offers a modular approach to managing application-level traffic routing in your AWS infrastructure.

## Features

- Creates an AWS Application Load Balancer (ALB).
- Configures a target group to handle application traffic.
- Sets up a listener to forward requests to the target group.

## Module Components

The module includes the following resources:
1. **Application Load Balancer** (`aws_alb`): 
   - Creates the ALB for handling application traffic.
   - Configurable with subnets, security groups, and tags.

2. **Target Group** (`aws_lb_target_group`):
   - Manages traffic routing to backend targets (e.g., EC2 instances, containers).
   - Supports protocol and port configuration, as well as tagging.

3. **Listener** (`aws_lb_listener`):
   - Listens for requests on a specified port and protocol.
   - Forwards requests to the target group.

## Input Variables

The module accepts several input variables for customization:
- `alb_name`: Name of the ALB.
- `subnets`: List of subnets for the ALB.
- `security_groups`: Security groups for the ALB.
- `target_group_name`: Name of the target group.
- `target_group_port`: Port for the target group.
- `target_group_protocol`: Protocol for the target group.
- `vpc_id`: VPC ID for the target group.
- `listener_port`: Port for the listener.
- `listener_protocol`: Protocol for the listener.
- `app_name`: Application name used in naming resources.
- `environment`: Environment name (e.g., dev, staging, prod).

## Tags

The module applies consistent tagging to all resources:
- Resources are tagged with `Name` in the format: `"<app_name>-alb-<environment>"`.

## Example Usage

Here’s an example of how to use this module:

```hcl
module "alb" {
  source                 = "./path-to-module"
  alb_name               = "my-alb"
  subnets                = ["subnet-12345678", "subnet-87654321"]
  security_groups        = ["sg-12345678"]
  target_group_name      = "my-target-group"
  target_group_port      = 80
  target_group_protocol  = "HTTP"
  vpc_id                 = "vpc-12345678"
  listener_port          = 80
  listener_protocol      = "HTTP"
  app_name               = "my-app"
  environment            = "dev"
}