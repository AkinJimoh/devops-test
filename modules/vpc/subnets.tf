resource "aws_subnet" "public_subnets" {
  count                   = length(var.net_config["subnet_cidr"])
  availability_zone       = element(var.net_config["azs"], count.index)
  cidr_block              = element(var.net_config["subnet_cidr"], count.index)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    Name = element(var.net_config["subnet_names"], count.index)
  }

}