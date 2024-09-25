terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
   backend "s3" {
     bucket = "my-unique-bucket-6ca5bb82"
     region = "eu-north-1"
     key = "terraform.tfstate"
     dynamodb_table = "easy-school"
     encrypt = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

# Create a VPC
resource "aws_vpc" "easy-school-vpc" {
  cidr_block = var.cidr_block
  tags = {
    Usage = "Demo"
  }
}

resource "aws_subnet" "easy-school-subnet" {
  vpc_id     = aws_vpc.easy-school-vpc.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Usage = "Create EC2"
  }
}

resource "aws_internet_gateway" "easy-school-gw" {
  vpc_id = aws_vpc.easy-school-vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "easy-school-route" {
  vpc_id = aws_vpc.easy-school-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.easy-school-gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.easy-school-subnet.id
  route_table_id = aws_route_table.easy-school-route.id
}

resource "aws_security_group" "allow_ssh" {
  name        = var.security_group_name
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.easy-school-vpc.id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Usage = "allow_ssh"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "easy-school-instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = "easy"
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  subnet_id                   = aws_subnet.easy-school-subnet.id
  associate_public_ip_address = true

  tags = {
    Usage = "My project with Terraform"
  }
}

output "ec2_public_ip" {
  value = aws_instance.easy-school-instance.public_ip
}

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
