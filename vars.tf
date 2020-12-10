variable "region" {
  type = map(string)
  default = {
    euw2 = "eu-west-2"
  }
}

variable "net_config" {
  type = map(any)
}

variable "vpc_cidr" {}
variable "instance_tenancy" {}
variable "enable_dns_support" {}
variable "enable_dns_hostnames" {}
variable "vpc_name" {}
variable "project" {}
variable "internet_gateway_name" {}
variable "rt_instance_count" {}
variable "alb_tg_name" {}
variable "target_group_port" {}
variable "target_group_protocol" {}
variable "alb_name" {}
variable "internal" {}