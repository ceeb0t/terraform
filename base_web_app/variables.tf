# variable "aws_access_key" {
#     type = string
#     description = "AWS Access Key"
#     sensitive = true
# }

# variable "aws_secret_key" {
#     type = string
#     description = "AWS Secret Key"
#     sensitive = true
# }

variable "aws_region" {
  type        = string
  description = "AWS Region to use"
  default     = "eu-west-1"
}

variable "sso_profile" {
  type        = string
  description = "SSO profile to use"
  default     = "CloudEngineer-ATGSandbox"
}

variable "aws_vpc_cdir_block" {
  type        = string
  description = "The CIDR block to create"
  default     = "10.0.0.0/16"
}

variable "aws_subnet_public_cdir_block" {
  type        = list(string)
  description = "The CIDR blocks for public subnet"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "nginx_ingress_port" {
  type        = string
  description = "Which port should nginx listen on"
  default     = "80"
}

variable "aws_instance_sizes" {
  type        = map(string)
  description = "Instance sizes to use in AWS"
  default = {
    small  = "t3.micro"
    tiny   = "t3.tiny"
    medium = "t3.medium"
  }
}

variable "company" {
  type        = string
  description = "Company Name for resource tagging"
  default     = "Globomantics"
}

variable "project" {
  type        = string
  description = "Project for resource tagging"
}

variable "billing_code" {
  type        = string
  description = "Billing Code for resource tagging"
}
