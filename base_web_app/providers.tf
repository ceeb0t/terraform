provider "aws" {
  profile = var.sso_profile
  region  = var.aws_region
}