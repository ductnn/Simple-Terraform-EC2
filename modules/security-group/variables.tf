variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of security group - not required if create_sg is false"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "cidr_block" {
  type = string
}

variable "egress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}
