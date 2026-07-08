output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.taskmanager_ec2.public_ip
}

output "alb_dns_name" {
  description = "DNS name of Load Balancer"
  value       = aws_lb.taskmanager_alb.dns_name
}

output "api_url" {
  description = "API URL"
  value       = "http://${aws_lb.taskmanager_alb.dns_name}"
}
