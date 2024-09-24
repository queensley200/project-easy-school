output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_public_ip_output" {
    value = aws_instance.my_ec2.public_ip
}


