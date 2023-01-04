output "security_group_id" {
  description = "The ID of private subnet"
  value       = aws_security_group.this.id
}
