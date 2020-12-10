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
}