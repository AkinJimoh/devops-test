#################################
# Provider Resource
#################################
provider "aws" {
  region = var.region.euw2
}

#################################
# VPC Resource
#################################
module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  instance_tenancy      = var.instance_tenancy
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames
  vpc_name              = var.vpc_name
  project               = var.project
  internet_gateway_name = var.internet_gateway_name
  net_config            = var.net_config
  rt_instance_count     = var.rt_instance_count
}

####################################
# Application-Load-Balancer Resource
####################################

module "alb" {
  source                = "./modules/application-load-balancer"
  region                = var.region.euw2
  alb_tg_name           = var.alb_tg_name
  target_group_port     = var.target_group_port
  target_group_protocol = var.target_group_protocol
  vpc_id                = module.vpc.vpc_id
  alb_name              = var.alb_name
  internal              = var.internal
  project               = var.project
  alb_subnets           = module.vpc.public_subnet_ids
}
####################################
# AutoScaling Resource
####################################
module "auto-scaling" {
  source                 = "./modules/auto-scaling"
  launch_config_name     = var.launch_config_name
  instance_type          = var.instance_type
  key                    = var.key
  autoscaling_group_name = var.autoscaling_group_name
  max_size               = var.max_size
  min_size               = var.min_size
  project                = var.project
  vpc_id                 = module.vpc.vpc_id
  grace_period           = var.grace_period
  check_type             = var.check_type
  force_delete           = var.force_delete
  vpc_zone_identifier    = module.vpc.public_subnet_ids
  tag_key                = var.tag_key
  tag_value              = var.tag_value
  target-group-arns      = module.alb.target_group_arn
  lb_sec_group           = module.alb.alb_sg
  instance_profile = module.s3.instance_profile
}
####################################
# S3 Bucket
####################################
module "s3" {
  source            = "./modules/s3"
  versioning        = var.versioning
  destroy           = var.destroy
  aws_bucket_prefix = var.aws_bucket_prefix
  profile_name      = var.profile_name
  role_name         = var.role_name
  role_policy       = var.role_policy
}