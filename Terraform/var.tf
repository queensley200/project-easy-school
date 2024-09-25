variable "cidr_block" {
  description = "For VPC cidr_block"
  default     = "10.0.0.0/16"
  type        = string
}

variable "security_group_name" {
  type = string
}

variable "subnet_cidr_block" {
    description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24" 
}

variable "instance_type" {
  type = string
}
