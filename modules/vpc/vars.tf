variable vpc_cidr {}
variable instance_tenancy {}
variable enable_dns_support {}
variable enable_dns_hostnames {}
variable vpc_name {}
variable project {}
variable internet_gateway_name {}
variable rt_instance_count {}

variable "net_config" {
  type = map(any)
}

