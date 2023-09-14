# Terraform Output Values
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.training_wedsite_instance.public_ip
}

output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = aws_instance.training_wedsite_instance.public_dns
}

output "instance_id" {
    description = "The Instance ID of the EC2 instance"
    value = aws_instance.training_wedsite_instance.id
}