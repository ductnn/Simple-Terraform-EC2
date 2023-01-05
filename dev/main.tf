data "aws_ami" "ubuntu_image" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210430"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  name   = "Demo"
  # region = var.common_aws_region
  region = "us-east-1"

  user_data = <<-EOT
  #!/bin/bash
  echo "DUMA !!!"
  EOT

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

module "ec2" {
  source = "../modules/ec2"

  ami                         = data.aws_ami.ubuntu_image.id
  instance_type               = "t2.medium"
  key_name                    = "test"
  availability_zone           = element(module.vpc.azs, 0)
  subnet_id                   = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp2"
      volume_size = 10
      tags = {
        Name = "my-root-block"
      }
    },
  ]

  tags = local.tags
}

# Support resources
module "vpc" {
  source = "../modules/vpc"
  # source  = "terraform-aws-modules/vpc/aws"
  # version = "~> 3.0"

  name = local.name
  cidr = "10.99.0.0/18"

  azs             = ["${local.region}a", "${local.region}b"]
  public_subnets  = ["10.99.0.0/24", "10.99.1.0/24"]
  private_subnets = ["10.99.3.0/24", "10.99.4.0/24"]

  tags = local.tags
}

module "security_group" {
  source = "../modules/security-group"

  name        = local.name
  description = "Security group for example usage with EC2 instance"
  vpc_id      = module.vpc.vpc_id
  cidr_block  = "10.99.0.0/18"

  tags = local.tags
}
