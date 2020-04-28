# Cloudfront configs with s3 backend, ACM ssl certs and logging
resource "aws_cloudfront_distribution" "portfolio" {
  provider = aws.global

  aliases = [var.naked_domain_name, var.www_domain_name]
  price_class = "PriceClass_100"
  enabled = true
  is_ipv6_enabled = true

  tags = local.terraform_tags

  viewer_certificate {
    ssl_support_method = "sni-only"
    acm_certificate_arn = data.aws_acm_certificate.certificate.arn
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  origin {
    origin_id = local.s3_origin_id
    domain_name = aws_s3_bucket.bucket.website_endpoint

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  logging_config {
    include_cookies = false
    bucket          =  aws_s3_bucket.logging_bucket.bucket_regional_domain_name
    prefix          = "log/"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    compress = true
    min_ttl = 60
    default_ttl = 600
    max_ttl = 600

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }
}