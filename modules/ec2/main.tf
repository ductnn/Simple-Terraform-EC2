locals {
  create = var.create
}

resource "aws_instance" "this" {
  count = local.create ? 1 : 0

  # instance
  ami           = var.ami
  instance_type = var.instance_type
  # not use
  ## cpu_core_count       = var.cpu_core_count
  ## cpu_threads_per_core = var.cpu_threads_per_core

  # user data
  user_data                   = var.user_data
  user_data_base64            = var.user_data_base64
  user_data_replace_on_change = var.user_data_replace_on_change

  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  key_name = var.key_name

  associate_public_ip_address = var.associate_public_ip_address

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      throughput            = lookup(root_block_device.value, "throughput", null)
      tags                  = lookup(root_block_device.value, "tags", null)
    }
  }

  # tags
  tags = merge({ "Name" = var.name }, var.tags)
}
