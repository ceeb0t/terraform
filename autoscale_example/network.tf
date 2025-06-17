
##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  enable_dns_hostnames = true

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false
}

# Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name                 = "example-asg"
  max_size             = 2
  min_size             = 1
  desired_capacity     = 1
  health_check_type    = "ELB"
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  vpc_zone_identifier = module.vpc.public_subnets # Use your VPC's public subnets
  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
  }
}