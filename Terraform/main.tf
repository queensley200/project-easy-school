provider "aws" {
  region = var.aws_region
}

# Call the VPC module
module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr
}

# Call the EC2 module
module "ec2" {
  source = "./modules/ec2"
  instance_type = var.instance_type
  ami_id = var.ami_id
  key_name = var.key_name
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}
