variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  
}

variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be launched"
  type        = string
  default = "subnet-12345678"
}

variable "vpc_id" {
  description = "The ID of the VPC in which the security group will be created"
  type        = string
  default = "vpc-12345678"
}