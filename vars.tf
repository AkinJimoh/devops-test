variable "region" {
  type = map(string)
  default = {
    euw2 = "eu-west-2"
  }
}

variable vpc_cidr {}
variable instance_tenancy {}
variable enable_dns_support {}
variable enable_dns_hostnames {}
variable vpc_name {}
variable project {}
variable internet_gateway_name {}