output "website_bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

output "website_region" {
  value = aws_s3_bucket.bucket.region
}

output "website_endpoint" {
  value = aws_s3_bucket.bucket.website_endpoint
}

output "website_bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "fqdn" {
  value = aws_route53_record.naked.fqdn
}
output "www_fqdn" {
  value = aws_route53_record.www.fqdn
}