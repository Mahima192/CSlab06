output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.lab_bucket.id
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.lab_test.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.lab_subnet.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.lab_sg.id
}
