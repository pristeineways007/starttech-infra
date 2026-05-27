Paste this into `ARCHITECTURE.md`:

```markdown
# StartTech Infrastructure Architecture

## Overview

All infrastructure is managed with Terraform and deployed on AWS in us-east-1.

## Network Architecture

```
VPC (10.0.0.0/16)
├── Public Subnet AZ1 (10.0.1.0/24)
│   ├── ALB
│   └── Bastion Host
├── Public Subnet AZ2 (10.0.2.0/24)
│   └── ALB
├── Private Subnet AZ1 (10.0.3.0/24)
│   ├── EC2 Instance
│   └── ElastiCache Redis
└── Private Subnet AZ2 (10.0.4.0/24)
    └── EC2 Instance
```

## Terraform Modules

### Networking Module
- VPC
- Public and private subnets across 2 AZs
- Internet Gateway
- NAT Gateway
- Route tables
- Security groups for ALB, EC2, Bastion, Redis

### Compute Module
- EC2 Launch Template
- Auto Scaling Group (min 2, max 4)
- Application Load Balancer
- ALB Target Group with health checks
- ALB Listener on port 80
- Bastion Host

### Storage Module
- S3 bucket for React frontend
- S3 bucket policy for public read access
- CloudFront distribution
- ElastiCache Redis cluster

### Monitoring Module
- CloudWatch Log Groups
- IAM Role for EC2 CloudWatch access
- IAM Instance Profile
- CloudWatch Alarms

## Security Groups

| Component | Inbound | Outbound |
|---|---|---|
| ALB | 80, 443 from internet | All |
| EC2 | 8080 from ALB, 22 from Bastion | All |
| Bastion | 22 from internet | All |
| Redis | 6379 from EC2 | All |

## CI/CD Pipeline

Triggers on push to main branch:
- Runs terraform fmt check
- Runs terraform validate
- Runs terraform plan on PRs
- Runs terraform apply on merge to main
```

Save and tell me when done.