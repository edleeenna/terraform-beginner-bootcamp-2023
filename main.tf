# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
   UserUuid = var.user_uuid
   Environment = "Dev"
  }
}
