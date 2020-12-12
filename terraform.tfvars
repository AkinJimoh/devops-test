vpc_cidr               = "10.0.0.0/16"
instance_tenancy       = "default"
enable_dns_support     = true
enable_dns_hostnames   = true
vpc_name               = "wipro-vpc"
project                = "devops-test"
internet_gateway_name  = "wipro-igw"
rt_instance_count      = 1
alb_tg_name            = "wipro-tg"
target_group_port      = 3000
target_group_protocol  = "HTTP"
alb_name               = "wipro-alb"
internal               = false
instance_type          = "t2.micro"
key                    = "awsky"
launch_config_name     = "wipro-lc-"
autoscaling_group_name = "wipro-asg"
max_size               = 4
min_size               = 2
grace_period           = 300
check_type             = "ELB"
force_delete           = true
tag_key                = "Name"
tag_value              = "wipro"
versioning             = "true"
destroy                = true
aws_bucket_prefix      = "wipro-test"
profile_name           = "wipro-ip"
role_name              = "wipro-iam"
role_policy            = "wipro-pol"


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
