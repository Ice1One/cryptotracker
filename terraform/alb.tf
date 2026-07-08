resource "aws_lb" "taskmanager_alb" {
  name               = "taskmanager-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
    var.public_subnet_1,
    var.public_subnet_2,
    var.public_subnet_3
  ]

  tags = {
    Name = "taskmanager-alb"
  }
}

resource "aws_lb_target_group" "taskmanager_tg" {
  name     = "taskmanager-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
  }

  tags = {
    Name = "taskmanager-tg"
  }
}

resource "aws_lb_listener" "taskmanager_listener" {
  load_balancer_arn = aws_lb.taskmanager_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.taskmanager_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "taskmanager_attachment" {
  target_group_arn = aws_lb_target_group.taskmanager_tg.arn
  target_id        = aws_instance.taskmanager_ec2.id
  port             = 8000
}
