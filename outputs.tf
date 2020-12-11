output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public Subnet IDS"
  value       = module.vpc.public_subnet_ids
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "alb_sg" {
  value = module.alb.alb_sg
}

output "alb_dns" {
  value = module.alb.alb_dns
}