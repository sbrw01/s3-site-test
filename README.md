# AWS static site project 

This project builds out the infrastructure for a static website on AWS via terraform.

## Design
***
As the site is hosting static content, the decision was made to host the website via a public s3 bucket with DNS configured by Route53. The CDN (Cloudfront) is used for high availability, content caching and scale. The content would be cached to locations near clients. It is advised to use CDN for request of more than 100,000 users. It is cloudfront that allows us to scale to large amounts of users with its edge capabilities for our scenario. A dynamic site would of followed a different design (ECS EKS, EC2 instead of S3)

## Terraform
***
The project consists of the following key AWS services:

 `S3 Bucket` - A public s3 bucket which contains the static configurations for the website along with a logging bucket for logging (s3.tf)

 `Route53` -  Public DNS external zone with the associated route53 records for the website and ACM setup (dns.tf)

 `CloudFront` - A CDN for caching content at the edge for high availability, latency, scale. Good for static web content (cloudfront.tf)

 `ACM` - Certificate manager for SSL certificate generation for website. SSL certicate is created manually as it is a manual process and definied as a data source (dns.tf)

 
***

Link to a example working site:

[https://sbrw.co.uk](https://sbrw.co.uk)


## How to run Project:
***

1) Populate the terraform.tfvars file with the following required variables:

`access_key` - Valid Access key for aws account

`secret_key` - Valid Secret key for aws account

`naked_domain_name` - DNS name for project (also the bucket name) your domain name

`www_domain_name` - CNAME E.G. www.<naked_domain_name>

> NOTE: Make sure you have a valid registered domain name set up and have registered for a cert via ACM for that domain (manual process).

2) Run the `run.sh` script in the /terraform directory to apply to AWS

## Tests
***

3) The terraform can be tested to see if it has been applied correctly using terraform inspec tests

> To run the tests (run the run.sh script in the root directory) :  `./run_tests.sh`

The cloudfront distribution has metrics and can be monitored via the monitoring page for Cloudfront under reports and analytics.
https://console.aws.amazon.com/cloudfront/v2/home?#/monitoring

## Delete project:
***
To destroy, please run:  `terraform destroy -auto-approve -refresh=true`
