resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.alb_subnets

  enable_deletion_protection = "false"


  tags = {
    Name    = var.alb_name
    Project = var.project
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "All access"
  description = "Public access to the load balancer"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.ingress_rules1

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  #allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name    = "wipro-alb-sg"
    Project = var.project
  }
}

resource "aws_alb_listener" "frontend" {
  default_action {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    type             = "forward"
  }
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
}
# ##################################################################################
# # Locals.
# ##################################################################################

locals {
  ingress_rules1 = [{
    port        = 80
    description = "Allows incoming traffic on port 80"
  }]
}