##################################################################################
# DATA
##################################################################################
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_launch_configuration" "launch_config" {
  name_prefix          = var.launch_config_name
  image_id             = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.tg_sg.id]
  key_name             = var.key
  user_data            = file("bootstrap.sh")
  iam_instance_profile = var.instance_profile

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling-group" {
  name                      = var.autoscaling_group_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.grace_period
  health_check_type         = var.check_type
  force_delete              = var.force_delete
  launch_configuration      = aws_launch_configuration.launch_config.name
  vpc_zone_identifier       = var.vpc_zone_identifier
  target_group_arns         = [var.target-group-arns]

  tags = [{
    key                 = var.tag_key
    propagate_at_launch = true
    value               = var.tag_value
  }]
}

resource "aws_security_group" "tg_sg" {
  #name        = "All access"
  description = "Access from load balancer"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.ingress_rules1

    content {
      description     = ingress.value.description
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      protocol        = "tcp"
      security_groups = [var.lb_sec_group]
    }
  }

  #allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name    = "wipro-tg-sg"
    Project = var.project
  }
}

# ##################################################################################
# # Locals.
# ##################################################################################

locals {
  ingress_rules1 = [{
    port        = 3000
    description = "Allows incoming traffic on port 3000"
  }]
}