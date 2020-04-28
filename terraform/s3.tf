locals { s3_origin_id = "bucket" }

# Public Website Bucket with versioning and logging enabled 
resource "aws_s3_bucket" "bucket" {
  bucket = var.naked_domain_name
  acl = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  
  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.logging_bucket.id
    target_prefix = "log/"
  }
  tags = local.terraform_tags
}

# Bucket policy to allow read access for anonymous users
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.naked_domain_name}/*"]
    }
  ]
}
POLICY
}

# Adding index.html file to website bucket
resource "aws_s3_bucket_object" "index_html" {
  acl          = "public-read"
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  source       = "../files/website/index.html"
  content_type = "text/html"

  #etag = filemd5("../files/website/index.html")
}

# Adding error.html file to website bucket
resource "aws_s3_bucket_object" "error_html" {
  acl          = "public-read"
  bucket       = aws_s3_bucket.bucket.id
  key          = "error.html"
  source       = "../files/website/error.html"
  content_type = "text/html"

  #etag = filemd5("../files/website/error.html")
}

# Bucket to store logs for website
resource "aws_s3_bucket" "logging_bucket" {
  bucket = var.logging_bucket_name
  acl    = "log-delivery-write"

  tags = local.terraform_tags
}