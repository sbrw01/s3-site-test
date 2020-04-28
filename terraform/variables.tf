variable "access_key" {
  description = "AWS access key"
}
variable "secret_key" {
  description = "AWS secret key"
}
variable "region" {
  description = "AWS region"
}

variable "logging_bucket_name" {
  description = "The name of the S3 Bucket to create for logging."
}

variable "naked_domain_name" {
  description = "The name of the S3 Bucket to create for logging."
}

variable "www_domain_name" {
  description = "The name of the S3 Bucket to create for logging."
}