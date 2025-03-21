# OpenJII DevOps Home Assessment Task

## Introduction

The objective of this assessment is to evaluate your practical knowledge of DevOps principles, tooling, infrastructure automation, and CI/CD processes. Your solutions will help us gauge how effectively you can contribute to the OpenJII project, a platform aimed at analyzing photosynthesis data through IoT sensors.

## Task Overview

You are required to set up a simple CI/CD pipeline that deploys a basic Node.js application to a cloud environment (preferably AWS) using infrastructure as code.

## Repository Structure

```
.
├── README.md                    # This file with instructions
├── app/                         # Node.js application
│   ├── package.json             # Node.js dependencies
│   ├── app.js                   # Application entry point
│   └── README.md                # Application documentation
├── terraform/                   # Starter terraform templates
│   └── README.md                # Terraform documentation
└── .github/                     # GitHub related files
    └── workflows/               # GitHub Actions workflows folder
        └── README.md            # Workflow documentation
```

## Tasks

### 1. CI/CD Pipeline Setup

**Task:** Set up a minimal CI/CD pipeline using GitHub Actions that builds the Node.js application, containerizes it using Docker, and pushes it to Docker Hub.

**Deliverable:** Complete GitHub Actions YAML file(s) in `.github/workflows/`, update the Dockerfile in the app directory, and provide a brief README outlining your workflow steps.

**Evaluation Criteria:**

- Clarity and readability of the YAML workflow
- Best practices in Docker containerization
- Documentation clarity

### 2. Infrastructure as Code (IaC)

**Task:** Provide an example of Infrastructure as Code using Terraform to deploy the above containerized application on AWS (e.g., using ECS Fargate).

**Deliverable:** Complete Terraform templates in the `terraform/` directory, with documentation explaining your architecture choices.

**Architecture considerations:**

- Security
- Scalability
- Cost-efficiency
- Basic monitoring and observability

## Assessment Criteria

- Clear, maintainable code and scripts
- Adherence to best practices (automation, IaC, security, simplicity)
- Implementation of basic monitoring and observability

## Submission

Fork this repository, implement your solution, and provide the link to your GitHub repository for evaluation.

## Getting Started

1. Fork this repository (Optional, you may also contribute directly)
2. Explore the Node.js application in the `app/` directory
3. Implement your CI/CD pipeline in `.github/workflows/`
4. Complete the Terraform templates in `terraform/`
5. Notify interviewers once the task is complete
