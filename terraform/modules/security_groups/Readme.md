# AWS Security Groups Terraform Module

This Terraform module configures **AWS Security Groups** to secure and control network traffic for an ECS service and its associated load balancer. It ensures proper ingress and egress rules for seamless communication while maintaining security.

## Features

- Creates a **Security Group** for the load balancer with open HTTP access.
- Configures a **Security Group** for the ECS service with cross-group connectivity.
- Defines both ingress and egress rules for secure and efficient traffic management.

## Module Components

The module includes the following resources:
1. **Load Balancer Security Group** (`aws_security_group.load_balancer_sg`):
   - Allows HTTP (port 80) access from any IP address (CIDR `0.0.0.0/0`).
   - Enables all outbound traffic for the load balancer.

2. **ECS Service Security Group** (`aws_security_group.ecs_service_sg`):
   - Allows all inbound traffic from the load balancer's security group.
   - Enables unrestricted outbound traffic for the ECS service.

## Input Variables

The module accepts the following input variables for customization:
- `app_name`: Application name used in naming resources.
- `environment`: Environment name (e.g., dev, staging, prod).
- `vpc_id`: VPC ID where the security groups will be created.

### Load Balancer Security Group Variables:
- `ingress_from_port`: Starting port for inbound traffic (default: 80).
- `ingress_to_port`: Ending port for inbound traffic (default: 80).
- `ingress_protocol`: Protocol for inbound traffic (default: TCP).
- `ingress_cidr_blocks`: CIDR blocks for inbound traffic (default: `["0.0.0.0/0"]`).
- `egress_protocol`: Protocol for outbound traffic (default: `-1` for all traffic).
- `egress_cidr_blocks`: CIDR blocks for outbound traffic (default: `["0.0.0.0/0"]`).

### ECS Service Security Group Variables:
- `load_balancer_sg_id`: ID of the load balancer security group to allow inbound traffic.

## Tags

Resources are tagged consistently with:
- `Name`: Formatted as `"<app_name>-<resource>-sg-<environment>"`.

## Example Usage

Here’s an example of how to use this module:

```hcl
module "security_groups" {
  source                = "./path-to-module"
  app_name              = "my-app"
  environment           = "dev"
  vpc_id                = "vpc-12345678"
}