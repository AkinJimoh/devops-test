resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  count  = var.rt_instance_count

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "${element(var.net_config["rt_name"], count.index)}-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.net_config["subnet_cidr"])
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_route_table.*.id, count.index)
}