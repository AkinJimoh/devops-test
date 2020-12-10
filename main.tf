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
  source      = "./modules/application-load-balancer"
  region      = var.region.euw2
  alb_tg_name = var.alb_tg_name
  target_group_port = var.target_group_port
  target_group_protocol = var.target_group_protocol
}