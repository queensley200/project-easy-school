variable "ami_id"{
 description = "id for ami"
  default     = "ami-0129bfde49ddb0ed6"
}

variable "instance_type"{
 description = "instance_type"
  default     = "t3.micro"
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






