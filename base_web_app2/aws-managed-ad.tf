resource "aws_directory_service_directory" "testing_autofutura" {
  name     = "testing.autofutura.com"
  password = "SuperSecretPassw0rd"
  size     = "Small"
    type     = "MicrosoftAD"
    description = "Managed AD for Testing"
    short_name = "testing"
    edition = "Standard"

  vpc_settings {
    vpc_id     = aws_vpc.app.id
    subnet_ids = [
        aws_subnet.private_subnet1.id,
        aws_subnet.private_subnet2.id
    ]
  }
}
