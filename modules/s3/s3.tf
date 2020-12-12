resource "aws_s3_bucket" "bucket" {
  bucket        = local.bucket_name
  acl           = "private"
  force_destroy = var.destroy

  versioning {
    enabled = var.versioning
  }
}

resource "random_integer" "wipro" {
  min = 1000
  max = 5000
}

resource "aws_s3_bucket_object" "object" {
  for_each = fileset("assets/", "*")
  bucket   = aws_s3_bucket.bucket.id
  key      = each.value
  source   = "assets/${each.value}"
}

resource "aws_iam_instance_profile" "ec2" {
  name = var.profile_name
  role = aws_iam_role.wipro.name
}

resource "aws_iam_role" "wipro" {
  name = var.role_name
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "wiproec2" {
  name = var.role_policy
  role = aws_iam_role.wipro.id

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ecr:ListImages",
                "ecr:BatchGetImage",
                "ecr:GetDownloadUrlForLayer"
            ],
            "Resource": "arn:aws:ecr:eu-west-2:458909167390:repository/wipro-p1"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ecr:GetAuthorizationToken",
            "Resource": "*"
        }
    ]
}
  EOF
}



####################################
# Locals
####################################
locals {
  bucket_name = "${var.aws_bucket_prefix}-${random_integer.wipro.result}"
}