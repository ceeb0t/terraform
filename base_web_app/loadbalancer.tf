
# resource "aws_lb"

resource "aws_lb" "nginx" {
  name               = "GloboWebAlb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

  enable_deletion_protection = false

  tags = local.common_tags
}

# resource "aws_lb_target_group"

resource "aws_lb_target_group" "taco_servers" {
  name     = "TacoApplicationServers"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app.id
}

# resource "aws_lb_target_group_attachement"

resource "aws_lb_target_group_attachment" "attach_taco_server_1" {
  target_group_arn = aws_lb_target_group.taco_servers.arn
  target_id        = aws_instance.nginx1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_taco_server_2" {
  target_group_arn = aws_lb_target_group.taco_servers.arn
  target_id        = aws_instance.nginx2.id
  port             = 80
}

# resource "aws_lb_listener"

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  protocol          = "HTTP"
  #   ssl_policy        = "ELBSecurityPolicy-2016-08"
  #   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.taco_servers.arn
  }
}