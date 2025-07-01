
##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "app" {
  cidr_block           = var.aws_vpc_cdir_block
  enable_dns_hostnames = true
}

resource "aws_subnet" "private_subnet1" {
  cidr_block              = var.aws_subnet_public_cdir_block[0]
  vpc_id                  = aws_vpc.app.id
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "private_subnet2" {
  cidr_block              = var.aws_subnet_public_cdir_block[1]
  vpc_id                  = aws_vpc.app.id
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]
}

# # ROUTING #
# resource "aws_route_table" "app" {
#   vpc_id = aws_vpc.app.id
#   tags   = local.common_tags
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.app.id
#   }
# }

# resource "aws_route_table_association" "app_subnet1" {
#   subnet_id      = aws_subnet.private_subnet1.id
#   route_table_id = aws_route_table.app.id
# }

# resource "aws_route_table_association" "app_subnet2" {
#   subnet_id      = aws_subnet.private_subnet2.id
#   route_table_id = aws_route_table.app.id
# }