resource "aws_instance" "ec2-demo-basic" {
  ami = data.aws_ami.ubuntu_image.id
  instance_type = var.instance_type

  # subnet_id = var.vpc_public_subnets
  # vpc_security_group_ids = var.list_security_group

  key_name = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install redis-tools -y
    sudo apt install mysql-client -y
  EOF
}