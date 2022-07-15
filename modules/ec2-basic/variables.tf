# variable "vpc_id" {
#   type        = string
#   description = "The VPC ID"
# }

# variable "vpc_public_subnets" {
#   description = "Public Subnet"
#   type        = string
# }

variable "instance_type" {
  description = "Type instance for provision bastionhost"
  default = "t2.medium"
}

variable "list_security_group" {
  description = "List security group for bastionhost"
}

variable "key_name" {}
