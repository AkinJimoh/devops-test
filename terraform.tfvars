vpc_cidr              = "10.0.0.0/16"
instance_tenancy      = "default"
enable_dns_support    = true
enable_dns_hostnames  = true
vpc_name              = "wipro-vpc"
project               = "devops-test"
internet_gateway_name = "wipro-igw"
rt_instance_count     = 1
alb_tg_name           = "wipro-tg"
target_group_port     = 80
target_group_protocol = "HTTP"
alb_name              = "wipro-alb"
internal              = false


net_config = {
  azs = [
    "eu-west-2a",
    "eu-west-2b",
  ]

  subnet_cidr = [
    "10.0.0.0/24",
    "10.0.1.0/24",
  ]

  subnet_names = [
    "wipro-pub1",
    "wipro-pub2",
  ]

  rt_name = [
    "wipro-web",
  ]
}
