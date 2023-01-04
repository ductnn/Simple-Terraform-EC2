locals {
  vpc_id = aws_vpc.this.id
}

# VPC
resource "aws_vpc" "this" {
  cidr_block = var.cidr

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = local.vpc_id

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

# Public Subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = local.vpc_id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

# Private Subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = local.vpc_id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

# Route table

# DHCP

# NAT Gateway
resource "aws_eip" "nat" {
  count = length(var.public_subnets)

  vpc = true

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}
