resource "aws_lb_target_group" "alb_tg" {
  name     = var.alb_tg_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
}