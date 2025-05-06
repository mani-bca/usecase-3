# General settings
aws_region   = "us-east-1"
project_name = "usecase-3-4"
environment  = "dev"

tags = {
  Environment = "dev"
  Project     = "delete"
}

# VPC settings
vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-1a"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = []
create_nat_gateway   = false

# EC2 settings
web_server_ami           = "ami-0e35ddab05955cf57"
web_server_instance_type = "t2.micro"
ssh_key_name             = "devops"
admin_ip_cidr            = "0.0.0.0/0"
root_volume_type         = "gp2"
root_volume_size         = 8
iam_instance_profile     = null
