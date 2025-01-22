## web app load balancer ##

resource "aws_lb" "application-load-balancer" {
  name = "web-external-load-balancer"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-security-group.id]
  subnets = [aws_subnet.public-web-subnet-1.id, aws_subnet.public-web-subnet-2.id]
  enable_deletion_protection = false

  tags = {
    Name = "App-load-balancer"
  }
  depends_on = [ aws_lb_target_group.aws_lb_target_group ]
}

resource "aws_lb_target_group" "aws_lb_target_group" {
  name = "appbalancertg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc_01.id
  depends_on = [ aws_vpc.vpc_01 ]
}

resource "aws_lb_target_group_attachment" "web-attachment" {
  target_group_arn = aws_lb_target_group.aws_lb_target_group.arn
  target_id = aws_instance.public-web-template.id
  port = 80
}

## create a listener on port 80 with redirect action ##

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application-load-balancer.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_target_group.arn
  }
  depends_on = [ aws_lb_target_group.aws_lb_target_group]
}