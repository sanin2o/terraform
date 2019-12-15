variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {}
variable "bucket_name" {}
variable "billing_id" {}
variable "website_objects_path" {}

locals {
  common_tags = {
    project     = var.bucket_name
    billing_id  = var.billing_id
    environment = "dev"
    created_by  = "terraform"
    managed_by  = "terraform"
  }

  content_types = {
    js   = "application/javascript"
    mp4  = "video/mp4"
    css  = "text/css"
    jpg  = "image/jpeg"
    png  = "image/png"
    html = "text/html"
  }
}
