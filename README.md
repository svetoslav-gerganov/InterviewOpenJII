# OpenJII DevOps Home Assessment Task


## Repository Structure

```
├───.github
│   └───workflows
├───.vs
│   └───devops_jii_interview_task
│       ├───FileContentIndex
│       └───v17
├───app
└───terraform
    ├───backend-config
    └───modules
        ├───alb
        ├───cloudwatch
        ├───ecs
        ├───security_groups
        └───vpc


### 1. CI/CD Pipeline Setup

In the current setup there are four (4) workflows as described in their Readme.

1. **CICD-Dev**
2. **CICD-Stage**
3. **CICD-Prod**
4. **Destroy-infra**

In brief - Dev pipe dockerizes, uploads and deploys the app to AWS. Stage and Prod take the Docker Image from DockerHub and deploys it based on the configurations for the environments. For more info please check .github/workflows/Readme.md and app/Readme.md for Dockerfile info.

### 2. Infrastructure as Code (IaC)

Terraform IaC is delivered using best practices in structuring and security. Please check terraform/Readme.md for more info.
