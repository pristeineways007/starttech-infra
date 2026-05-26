output "iam_instance_profile" {
  description = "IAM instance profile name for EC2"
  value       = aws_iam_instance_profile.ec2_cloudwatch.name
}

output "app_log_group_name" {
  description = "Application log group name"
  value       = aws_cloudwatch_log_group.app.name
}

output "nginx_log_group_name" {
  description = "Nginx log group name"
  value       = aws_cloudwatch_log_group.nginx.name
}