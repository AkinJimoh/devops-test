output "target_group_arn" {
  value = aws_lb_target_group.alb_tg.arn
}

output "alb_sg" {
  value = aws_security_group.alb_sg
}