#!/bin/bash

set -e

echo "Starting infrastructure deployment..."

# Variables
AWS_REGION="us-east-1"
TERRAFORM_DIR="../terraform"

# Check AWS credentials
echo "Checking AWS credentials..."
aws sts get-caller-identity > /dev/null 2>&1 || {
  echo "ERROR: AWS credentials not configured"
  exit 1
}

# Go into terraform directory
cd $TERRAFORM_DIR

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Validate Terraform
echo "Validating Terraform..."
terraform validate

# Plan Terraform
echo "Planning Terraform..."
terraform plan -out=tfplan

# Apply Terraform
echo "Applying Terraform..."
terraform apply tfplan

# Show outputs
echo "Infrastructure deployed successfully!"
echo "Outputs:"
terraform output

echo "Done!"