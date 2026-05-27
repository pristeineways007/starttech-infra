Paste this into `README.md`:

```markdown
# StartTech Infrastructure

Complete AWS infrastructure for the StartTech application, managed with Terraform.

## Infrastructure Components

- **VPC** with public and private subnets across 2 Availability Zones
- **EC2 Auto Scaling Group** for the Golang backend
- **Application Load Balancer** for traffic distribution
- **S3 bucket** for React frontend hosting
- **CloudFront CDN** for global content delivery
- **ElastiCache Redis** for caching and sessions
- **CloudWatch** for logging and monitoring
- **IAM roles** with least privilege access

## Repository Structure

```
starttech-infra/
├── .github/
│   └── workflows/
│       └── infrastructure-deploy.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   └── modules/
│       ├── networking/
│       ├── compute/
│       ├── storage/
│       └── monitoring/
├── scripts/
│   └── deploy-infrastructure.sh
├── monitoring/
│   ├── cloudwatch-dashboard.json
│   ├── alarm-definitions.json
│   └── log-insights-queries.txt
├── ARCHITECTURE.md
├── RUNBOOK.md
└── README.md
```

## Prerequisites

- Terraform v1.0+
- AWS CLI configured
- AWS account with required permissions

## Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/pristeineways007/starttech-infra.git
cd starttech-infra
```

### 2. Configure variables
```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
```

Edit `terraform.tfvars` with your values.

### 3. Deploy infrastructure
```bash
cd scripts
./deploy-infrastructure.sh
```

### 4. Get outputs
```bash
cd terraform
terraform output
```

## CI/CD Pipeline

The infrastructure pipeline triggers automatically on push to main:
- `terraform fmt` check
- `terraform validate`
- `terraform plan` on pull requests
- `terraform apply` on merge to main

## GitHub Secrets Required

| Secret | Description |
|---|---|
| `AWS_ACCESS_KEY_ID` | AWS access key |
| `AWS_SECRET_ACCESS_KEY` | AWS secret key |

## Destroying Infrastructure

To avoid AWS charges, destroy infrastructure when done:

```bash
cd terraform
terraform destroy
```

## Documentation

- [Architecture](ARCHITECTURE.md) - System architecture details
- [Runbook](RUNBOOK.md) - Operations and troubleshooting guide
```

Save and tell me when done.