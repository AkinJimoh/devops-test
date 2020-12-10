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
variable "launch_config_name" {}
variable "instance_type" {}
variable "key" {}
variable "autoscaling_group_name" {}
variable "max_size" {}
variable "min_size" {}
variable "grace_period" {}
variable "check_type" {}
variable "force_delete" {}
variable "tag_key" {}
variable "tag_value" {}