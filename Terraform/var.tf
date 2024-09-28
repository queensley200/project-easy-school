variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "eu-north-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "Type of instance"
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0129bfde49ddb0ed6"  # Amazon Linux 2 AMI
}

variable "key_name" {
  description = "Key pair name for EC2"
  default = "easy"
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

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  
}






