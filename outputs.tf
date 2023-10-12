 output "bucket_name" {
   description = "Bucket name for our static website hosting"
   value = module.home_one_hosting.bucket_name
 }
 
 output "website_endpoint" {
   description = "S3 static website hosting endpoint"
   value = module.home_one_hosting.website_endpoint
 }
 
 output "cloudfront_url" {
   description = "The CloudFront distribution Domain Name"
   value = module.home_one_hosting.domain_name
 }