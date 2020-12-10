variable "region" {}
variable "alb_tg_name" {}
variable "target_group_port" {}
variable "target_group_protocol" {}
variable "vpc_id" {}
variable "alb_name" {}
variable "internal" {}
variable "project" {}

variable "alb_subnets" {
  type = list
}