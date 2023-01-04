locals {
  create = var.create
}

resource "aws_security_group" "this" {
  #   count = local.create ? 1 : 0

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}
