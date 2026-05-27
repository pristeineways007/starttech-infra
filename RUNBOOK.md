Now paste this into `RUNBOOK.md`:

```markdown
# StartTech Infrastructure Runbook

## Prerequisites
- Terraform installed
- AWS CLI configured
- Access to AWS account 430776404303

## Initial Deployment

### Deploy All Infrastructure
```bash
cd scripts
./deploy-infrastructure.sh
```

### Verify Deployment
```bash
cd terraform
terraform output
```

## Common Operations

### Add More EC2 Instances Manually
```bash
aws autoscaling set-desired-capacity \
  --auto-scaling-group-name starttech-asg \
  --desired-capacity 3
```

### View CloudWatch Logs
```bash
aws logs tail /starttech/production/app --follow
```

### SSH Into Bastion Host
```bash
ssh -i ways.pem ec2-user@<bastion-public-ip>
```

### Get All Infrastructure Outputs
```bash
cd terraform
terraform output
```

## Troubleshooting

### Terraform Apply Fails

1. Check AWS credentials:
```bash
aws sts get-caller-identity
```

2. Check Terraform state:
```bash
terraform state list
```

3. Try refreshing state:
```bash
terraform refresh
```

### EC2 Instances Not Starting

1. Check ASG activity:
```bash
aws autoscaling describe-scaling-activities \
  --auto-scaling-group-name starttech-asg
```

2. Check launch template for errors in AWS Console

### ALB Health Checks Failing

1. Verify backend is running on port 8080
2. Check security group allows ALB to reach EC2 on port 8080
3. Check /health endpoint returns 200

### ElastiCache Not Accessible

1. Verify security group allows EC2 to reach Redis on port 6379
2. Check Redis cluster status in AWS Console
3. Verify subnet group has correct subnets

## Destroying Infrastructure

When done, destroy everything to stop AWS billing:

```bash
cd terraform
terraform destroy
```

Type `yes` when prompted.

This will delete ALL AWS resources including:
- VPC and subnets
- EC2 instances and ASG
- ALB
- S3 bucket and CloudFront
- ElastiCache Redis
- CloudWatch log groups
- IAM roles
```

Save and tell me when done.