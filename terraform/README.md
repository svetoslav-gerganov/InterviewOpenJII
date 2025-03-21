# Modular AWS Infrastructure with Terraform

This repository provides a modular and scalable framework for provisioning an application architecture on AWS using Terraform. The setup includes networking, compute resources, application load balancing, security configurations, and monitoring, enabling efficient deployment of a containerized application in the cloud.

## 🏗️ What's in the Stack?

The architecture uses several Terraform modules to achieve a clean, reusable, and well-structured infrastructure design. Here's the big picture:

- **Networking First**: The **VPC Module** establishes the foundation of the network, including public subnets and internet connectivity.
- **Security at the Core**: The **Security Groups Module** ensures the network is locked down, only allowing the necessary traffic between the application, load balancer, and the internet.
- **Container Orchestration**: The **ECS Module** deploys the application as containerized services using AWS Fargate, ensuring portability and scalability.
- **Traffic Management**: The **ALB Module** (Application Load Balancer) handles routing HTTP traffic to your ECS tasks, maintaining seamless user experiences.
- **Monitoring & Alerts**: The **CloudWatch Module** integrates monitoring and alerting capabilities, keeping you informed about the health and performance of your application.

## 📖 How It All Fits Together

1. **Networking (VPC)**: A Virtual Private Cloud is created with two public subnets spanning across availability zones for high availability. This ensures that all resources have a secure and isolated network boundary.
2. **Security**: Separate security groups are defined for the load balancer and ECS tasks, controlling ingress/egress rules for safe communication.
3. **Load Balancing**: The Application Load Balancer is configured to route traffic to ECS tasks based on target groups, ensuring scalability and fault tolerance.
4. **ECS Services**: Containers running your application are deployed to ECS services with Fargate. These services are connected to the load balancer and operate within the network defined by the VPC and security groups.
5. **Observability**: CloudWatch monitors ECS metrics (e.g., CPU and memory utilization) and application logs, enabling proactive alerting and troubleshooting.

---

## 🚀 Quick Start

Here’s how you can provision the entire infrastructure:

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   cd ./terraform
   terrafrom init
   terraform validate 
   terraform plan
   terraform plan -var "docker_image=DockerUserName/ImageName:tag" -var "environment=Dev"
   terraform apply -var "docker_image=DockerUserName/ImageName:tag" -var "environment=Dev"

