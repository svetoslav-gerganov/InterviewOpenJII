# GitHub Actions Workflows

## Main Workflows

This repository contains the following GitHub Actions workflows for managing the CI/CD pipelines and infrastructure deployment of the Node.js application:

1. **CICD-Dev**
2. **CICD-Stage**
3. **CICD-Prod**
4. **Destroy-infra**

---

## CICD-Dev

### **Overview**

The `CICD-Dev` workflow automates the Continuous Integration and Continuous Deployment (CI/CD) pipeline for the **Dev Environment**. It ensures robust testing, Dockerization, and infrastructure provisioning using Terraform.
Its main purpose is to build, test, containerize the application and plan and apply using Terraform. Further pipeplines use the ready uploaded image and deploy to the selected environments. 

---

### **Highlights**

- **Reusable Artifacts**: Efficiently reuses the Docker image tag artifact from the **CICD-Dev** workflow, ensuring consistency between environments.
- **Secure Authentication**:
  - Leverages GitHub Secrets for Docker Hub and AWS credentials to ensure secure interactions.
- **Stage-Specific Configuration**:
  - Uses `stage-backend.conf` for backend configuration and applies changes specific to the Stage environment.
- **Resilient Pipeline**: Fails gracefully if any step encounters an error (e.g., dependency installation, tests, Docker build, or Terraform validation).
- **Artifact Management**: Uses artifacts for seamless variable passing between jobs (e.g., Docker image tag).
- **Automation**: Combines CI/CD best practices with Terraform to automate infrastructure management.
- **Environment Segregation**: Each pipeline uses its own github envronment, variables, TF plans, state-files.
- **Failsafe for destroy**: Destruction of Prod environment includes safety mechanism.

---

### **Workflow Steps**

#### **Job 1: Build and Test**

**Purpose**: Ensures the Node.js application is functional and ready for deployment.

- **Checkout Code**: Retrieves the latest code from the repository.
- **Set up Node.js**: Installs Node.js version 18.
- **Install Dependencies**: Installs application dependencies (`npm install`).
- **Run Tests**: Executes the app’s test suite (`npm test`) to ensure code quality.

---

#### **Job 2: Build and Push Docker Image**

**Purpose**: Builds a Docker image for the application and pushes it to Docker Hub.

- **Checkout Code**: Fetches the code for Docker image creation.
- **Log in to Docker Hub**: Authenticates with Docker Hub using credentials stored in GitHub Secrets.
- **Build Docker Image**:
  - Builds the image with tags: 
    - Unique tag using the workflow run ID.
    - `latest` tag for the most recent version.
- **Push Docker Image**: Pushes both tags to Docker Hub.
- **Artifact Creation**: Stores the `latest` Docker image tag as an artifact (`docker-image-tag.txt`) for use in subsequent jobs.

---

#### **Job 3: Terraform Plan and Apply**

**Purpose**: Manages the application infrastructure deployment in the Dev Environment using Terraform.

- **Checkout Code**: Retrieves Terraform configuration files.
- **Set up Terraform**: Installs and configures Terraform (version 1.11.0).
- **Download Artifact**: Retrieves the Docker image tag artifact.
- **Set Docker Image Variable**: Reads the Docker image tag and sets it as an environment variable.
- **Initialize Terraform**: Prepares the Terraform backend configuration (`dev-backend.conf`).
- **Format and Validate**:
  - Formats (`terraform fmt`) and validates (`terraform validate`) the Terraform configuration files.
- **Terraform Plan**:
  - Generates a Terraform plan to update infrastructure with the Docker image and environment variables.
  - Saves the plan as `plan-dev-<run_id>.tfplan`.
- **Upload Terraform Plan**: Stores the Terraform plan as an artifact.
- **Terraform Apply**:
  - Executes the plan to provision/update the infrastructure in the Dev Environment.

---

## CICD-Stage

### **Overview**

The `CICD-Stage` workflow automates the CI/CD pipeline for the **Stage Environment**. It reuses the Docker image produced in the **Dev Workflow** and deploys the infrastructure in the **Stage Environment** using Terraform.

---

### **Workflow Steps**

#### **Job 1: Fetch Run ID**

**Purpose**: Fetches the Docker image tag from the **CICD-Dev** workflow to use in the Stage deployment.

- **Steps**:
  1. **Fetch Run ID of `CICD-Dev`**:
     - Retrieves the latest successful run ID of the `CICD-Dev` workflow using the GitHub API.
     - This ensures the Stage environment uses the Docker image generated by the most recent Dev workflow run.
  2. **Download Docker Image Tag Artifact**:
     - Fetches the `docker-image-tag` artifact from the `CICD-Dev` workflow run, containing the Docker image tag (`node-jii-app:latest`).
  3. **Set Docker Image Variable**:
     - Reads the Docker image tag from the downloaded artifact and sets it as an environment variable (`DOCKER_IMAGE`) and a job output (`docker_image`) for use in subsequent jobs.
  4. **Verify Docker Image**:
     - Prints the Docker image tag to the logs to confirm successful retrieval.

---

#### **Job 2: Terraform**

**Purpose**: Deploys or updates the Stage environment infrastructure using Terraform.

- **Dependencies**:
  - This job depends on the successful completion of the **Fetch Run ID** job (`needs: fetch-run-id`) to ensure the Docker image tag is available.

- **Steps**:
  1. **Access Docker Image Variable**:
     - Verifies the Docker image variable received from the previous job by printing it to the logs.
  2. **Checkout Code**:
     - Retrieves the Terraform configuration files.
  3. **Set up Terraform**:
     - Installs and configures Terraform (version `1.11.0`) for consistent infrastructure provisioning.
  4. **Initialize Terraform**:
     - Prepares the Terraform backend configuration using the Stage-specific backend file (`stage-backend.conf`).
  5. **Format and Validate Terraform Files**:
     - Formats (`terraform fmt`) and validates (`terraform validate`) the Terraform configuration files for accuracy and compliance.
  6. **Generate Terraform Plan**:
     - Creates a plan file that specifies the infrastructure changes required for the Stage environment:
       - Incorporates the Docker image tag (`DOCKER_IMAGE`) and `environment` variable (`Stage`) into the Terraform plan.
       - The plan is saved as `plan-stage-<run_id>.tfplan`.
  7. **Upload Terraform Plan**:
     - Stores the Terraform plan as an artifact for debugging or reference.
  8. **Check Docker Image Variable in Terraform Plan**:
     - Confirms the Docker image variable used in the Terraform plan.
  9. **Apply Terraform Changes**:
     - Executes the Terraform plan to provision or update resources in the Stage environment automatically (`-auto-approve`).

---

## CICD-Prod

### **Overview**

The `CICD-Prod` workflow automates the CI/CD pipeline for the **Production Environment**. It reuses the Docker image created in the **CICD-Dev** workflow and manages infrastructure provisioning for production using Terraform.

---

### **Workflow Steps**

#### **Job 1: Fetch Run ID**

**Purpose**: Fetches the Docker image tag from the **CICD-Dev** workflow to use in the Production deployment.

- **Steps**:
  1. **Fetch Run ID of `CICD-Dev`**:
     - Queries the GitHub API to fetch the latest successful run ID of the `CICD-Dev` workflow.
     - Ensures that the production deployment uses the most recent Docker image generated by the `CICD-Dev` workflow.
  2. **Download Docker Image Tag Artifact**:
     - Downloads the `docker-image-tag` artifact from the `CICD-Dev` workflow run. This artifact contains the Docker image tag (`node-jii-app:latest`) to be used in the production deployment.
  3. **Set Docker Image Variable**:
     - Reads the Docker image tag from the artifact and sets it as:
       - An environment variable (`DOCKER_IMAGE`) for use in this job and subsequent jobs.
       - An output variable (`docker_image`) for the `terraform` job.

---

#### **Job 2: Terraform**

**Purpose**: Provisions or updates the Production environment infrastructure using Terraform.

- **Dependencies**:
  - Runs after the successful completion of **Fetch Run ID** (`needs: fetch-run-id`), ensuring the Docker image tag is correctly passed.

- **Steps**:
  1. **Access Docker Image Variable**:
     - Prints the Docker image variable obtained from the previous job for verification.
  2. **Checkout Code**:
     - Retrieves the Terraform configuration files for infrastructure provisioning.
  3. **Set up Terraform**:
     - Installs and configures Terraform (version `1.11.0`) for consistency across environments.
  4. **Initialize Terraform**:
     - Prepares the Terraform backend configuration using the production-specific backend file (`prod-backend.conf`).
  5. **Format and Validate Terraform Files**:
     - Formats (`terraform fmt`) and validates (`terraform validate`) the Terraform configuration files for correctness and compliance.
  6. **Generate Terraform Plan**:
     - Creates a Terraform execution plan for the Production environment:
       - Uses the Docker image tag (`DOCKER_IMAGE`) and environment (`Prod`) as variables.
       - Saves the plan as `plan-prod-<run_id>.tfplan`.
  7. **Upload Terraform Plan**:
     - Stores the Terraform plan as an artifact for reference or debugging.
  8. **Check Docker Image Variable in Terraform Plan**:
     - Verifies the Docker image variable used in the Terraform plan.
  9. **Apply Terraform Changes**:
     - Executes the Terraform plan to provision or update resources in the Production environment automatically (`-auto-approve`).

---

## Destroy-infra

### **Overview**

The `Destroy-infra` workflow automates the destruction of infrastructure resources for the specified environment (`dev`, `stage`, or `prod`). It includes safety mechanisms to prevent accidental destruction of the production environment.

---

### **Workflow Steps**

#### **Safety Confirmation for Production**

- Ensures that destruction in the production environment requires an additional confirmation (`PROD_DESTROY`).
- If the confirmation is missing or incorrect, the workflow exits immediately without applying changes.

---

#### **
