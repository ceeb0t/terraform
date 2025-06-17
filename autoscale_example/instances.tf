resource "aws_launch_template" "lt" {
  name_prefix   = "example-launch-template-"
  image_id      = "ami-015b1e8e2a6899bdb"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data = base64encode(<<EOF
#!/bin/bash
echo "Hello, World!" > index.html
nohup busybox httpd -f -p 8080 &
EOF
)
}