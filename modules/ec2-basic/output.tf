output "basionhost_public_ip" {
  value = aws_instance.ec2-demo-basic.public_ip
}
