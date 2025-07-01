variable "subnet_id" {
  description = "The ID of the existing subnet"
  type        = string
}

data "aws_subnet" "existing" {
  id = var.subnet_id
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  # other configuration
}
