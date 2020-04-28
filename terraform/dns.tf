# external zone 
resource "aws_route53_zone" "primary" {
  name = var.naked_domain_name
}

# www cname record set
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name = var.www_domain_name
  type = "A"

  alias {
    evaluate_target_health = false
    name = aws_cloudfront_distribution.portfolio.domain_name
    zone_id = aws_cloudfront_distribution.portfolio.hosted_zone_id
  }
}

# Naked domain record set
resource "aws_route53_record" "naked" {
  zone_id = aws_route53_zone.primary.zone_id
  name = var.naked_domain_name
  type = "A"

  alias {
    evaluate_target_health = false
    name = aws_cloudfront_distribution.portfolio.domain_name
    zone_id = aws_cloudfront_distribution.portfolio.hosted_zone_id
  }
}


# This part has to be manually created in AWS certificate certificate manager and defined below.
data "aws_acm_certificate" "certificate" {
  provider = aws.global

  domain = var.naked_domain_name
  statuses = ["ISSUED"]
  most_recent = true
}