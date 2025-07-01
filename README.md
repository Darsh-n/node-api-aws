Task API Project
This project is a Node.js-based RESTful API with Docker containerization, AWS infrastructure provisioned via Terraform, and a CI/CD pipeline using Jenkins. It includes high availability, security best practices, monitoring, and logging.
Features

Node.js API: Express-based API with /health and /tasks endpoints, connected to PostgreSQL.
Testing: Unit tests for endpoints using Jest.
Containerization: Dockerized app with a non-root user and PostgreSQL via docker-compose.
Infrastructure: AWS VPC, EC2 Auto Scaling Group, ALB, RDS, and ECR provisioned with Terraform.
CI/CD: Jenkins pipeline for testing, building, and deploying to AWS.
High Availability: Auto Scaling Group and ALB with health checks.
Security: HTTPS (via ACM), restricted SSH, secrets in AWS Secrets Manager, and RDS encryption.
Monitoring: CloudWatch for metrics and alarms, with optional Prometheus + Grafana.
Logging: JSON-structured logs with Winston, shipped to CloudWatch.

Prerequisites

Node.js 18+
Docker and Docker Compose
Terraform 1.5+
AWS CLI configured with access keys
Jenkins server with Docker and AWS CLI installed
AWS account with permissions for VPC, EC2, ALB, RDS, ECR, and CloudWatch

Directory Structure
task-api/
├── Jenkinsfile                      # Jenkins pipeline
├── terraform/                      # Terraform configurations
│   ├── main.tf
│   ├── variables.tf
│   ├── cloudwatch.tf
├── Dockerfile                      # Docker configuration
├── docker-compose.yml              # Local multi-container setup
├── index.js                        # Node.js API code
├── index.test.js                   # Jest unit tests
├── package.json                    # Node.js dependencies
├── .env                            # Environment variables
├── README.md                       # This file

Setup Instructions
1. Local Development

Clone the Repository
git clone <your-repo-url>
cd task-api


Install Dependencies
npm install


Set Up Environment VariablesCreate a .env file based on the provided .env example:
PORT=3000
DB_USER=postgres
DB_HOST=localhost
DB_NAME=tasks_db
DB_PASSWORD=your_secure_password
DB_PORT=5432


Run Locally with Docker Compose
docker-compose up --build

The API will be available at http://localhost:3000.

Run Tests
npm test



2. Infrastructure Setup (AWS)

Install TerraformDownload and install Terraform: https://www.terraform.io/downloads

Configure AWS CLI
aws configure


Set Up Terraform VariablesIn terraform/variables.tf, update:

region: Your AWS region (e.g., us-east-1).
allowed_ssh_cidr: Your IP address for SSH access (e.g., 203.0.113.0/32).
alert_email: Your email for CloudWatch alarms.


Initialize Terraform
cd terraform
terraform init


Apply Terraform Configuration
terraform apply -var="db_username=postgres" -var="db_password=your_secure_password"

This provisions:

VPC with public/private subnets
EC2 Auto Scaling Group
Application Load Balancer
RDS PostgreSQL instance
ECR repository



3. CI/CD Pipeline (Jenkins)

Set Up Jenkins

Install Jenkins on a server or use a cloud-based Jenkins instance.
Install plugins: Pipeline, Docker Pipeline, AWS Credentials, and NodeJS.
Install Docker and AWS CLI on the Jenkins server.


Configure Jenkins CredentialsIn Jenkins, add the following credentials:

aws-credentials: AWS Access Key ID and Secret Access Key (kind: AWS Credentials).
aws-account-id: Your AWS account ID (kind: Secret text).
db-username: Database username (kind: Secret text).
db-password: Database password (kind: Secret text).


Create Jenkins Pipeline

Create a new Pipeline job in Jenkins.
Select "Pipeline script from SCM".
Configure the repository URL and set the script path to Jenkinsfile.
Save and run the pipeline.

The pipeline includes:

Checkout: Clones the repository.
Test: Runs unit tests with Jest.
Build Docker Image: Builds the Docker image.
Push to ECR: Pushes the image to AWS ECR.
Deploy: Applies Terraform configuration, with rollback on failure.



4. Security Configuration

HTTPS: Request an ACM certificate in AWS and update main.tf to use HTTPS listener (port 443).
Secrets: Store db_username and db_password in AWS Secrets Manager for production.
SSH Access: Ensure allowed_ssh_cidr is set to a specific IP range.

5. Monitoring and Alerts

CloudWatch: Metrics (CPU, memory, error rates) and alarms are set up via cloudwatch.tf.
Optional Prometheus + Grafana:
Add express-prometheus-middleware to index.js.
Deploy Prometheus and Grafana using Docker Compose or AWS Managed Grafana.
Create dashboards for CPU, memory, and request rates.



6. Logging

Logs are structured in JSON format using Winston (index.js).
Configure CloudWatch agent on EC2 to ship logs to CloudWatch Logs.
Optional: Deploy ELK Stack (Elasticsearch, Logstash, Kibana) and use Fluent Bit to ship logs.

Accessing the API

Local: http://localhost:3000/health, http://localhost:3000/tasks
AWS: Use the ALB DNS name (output by Terraform) to access the API.

Troubleshooting

Docker Issues: Ensure Docker is running and ports are free.
Terraform Errors: Verify AWS credentials and variable values.
Jenkins Failures: Check Jenkins console output and ensure credentials are correct.
Database Connection: Confirm RDS security group allows traffic from EC2.

Next Steps

Add Prometheus/Grafana for advanced monitoring.
Implement ELK Stack for centralized logging.
Enhance API with additional endpoints and validation.
Configure AWS Secrets Manager for secure credential management.
