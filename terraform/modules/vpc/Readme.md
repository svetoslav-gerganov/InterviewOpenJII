# AWS VPC Terraform Module

This Terraform module provisions a **Virtual Private Cloud (VPC)** in AWS with public subnets, an internet gateway, and routing configurations. The module is designed for flexible and scalable infrastructure while ensuring connectivity and modularity.

## Features

- Creates a **VPC** with a customizable CIDR block.
- Provisions **public subnets** for hosting resources across availability zones.
- Configures an **Internet Gateway (IGW)** for external connectivity.
- Establishes a **Route Table** with routes for internet access.
- Associates subnets with the route table for seamless traffic routing.

## Module Components

The module includes the following resources:
1. **VPC** (`aws_vpc`):
   - Defines the network boundary for your AWS resources.
   - Customizable CIDR block.

2. **Subnets** (`aws_subnet`):
   - Creates two subnets, one in each specified availability zone.
   - Subnets are configured to auto-assign public IPs.

3. **Internet Gateway** (`aws_internet_gateway`):
   - Provides internet connectivity for resources in the VPC.

4. **Route Table** (`aws_route_table`):
   - Manages routes for the VPC, including a default route to the IGW.

5. **Route** (`aws_route`):
   - Adds a route for internet traffic (`0.0.0.0/0`) to the IGW.

6. **Subnet Associations** (`aws_route_table_association`):
   - Associates the public subnets with the route table.

## Input Variables

The module accepts the following input variables:
- `app_name`: Application name used in naming resources.
- `environment`: Environment name (e.g., dev, staging, prod).
- `cidr_block`: CIDR block for the VPC.
- `aws_region`: AWS region for creating subnets.

### Default Configuration for Subnets:
- Two subnets with CIDR blocks derived from the VPC’s CIDR.
- Subnets placed in the first two availability zones (`a` and `b`) of the specified AWS region.

## Tags

All resources are tagged consistently with:
- `Name`: Formatted as `"<app_name>-<resource>-<environment>"`.

## Example Usage

Here’s an example of how to use this module:

```hcl
module "vpc" {
  source       = "./path-to-module"
  app_name     = "my-app"
  environment  = "dev"
  cidr_block   = "10.0.0.0/16"
  aws_region   = "us-east-1"
}