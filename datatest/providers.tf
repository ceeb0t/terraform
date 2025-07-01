terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}
provider "aws" {
  profile = "ATG_Common_Sandbox"
  region  = "eu-west-1"
    
}

