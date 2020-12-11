output "s3-bucketid" {
  value = aws_s3_bucket.bucket.id
}

output "s3-bucket-arn" {
  value = aws_s3_bucket.bucket.arn
}

output "instance_profile" {
    value = aws_iam_instance_profile.ec2.id
}