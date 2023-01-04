output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID"
}

output "public_subnets" {
  value       = aws_subnet.public[*].id
  description = "List of public subnet IDs"
}

output "private_subnets" {
  value       = aws_subnet.private[*].id
  description = "List of private subnet IDs"
}

output "vpc_cidr_block" {
  value       = aws_vpc.this.cidr_block
  description = "The CIDR block of the VPC"
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = var.azs
}

output "name" {
  description = "The name of the VPC specified as argument to this module"
  value       = var.name
}
