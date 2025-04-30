output "aws_alb_public_dns" {
  value       = "https://${aws_lb.nginx.dns_name}"
  description = "Public DNS Hostname"
}
output "aws_instance_ami" {
  value       = "aws_instance.ami"
  description = "AMI file used"
}