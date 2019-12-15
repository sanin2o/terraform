module "bucket" {
  bucket_name = var.bucket_name

  source      = "..\\modules\\s3_website_static"
  common_tags = local.common_tags
}

resource "aws_s3_bucket_object" "bucket_object" {
  for_each = fileset("${var.website_objects_path}", "**/*")

  bucket       = module.bucket.bucket.id
  key          = each.value
  source       = "${var.website_objects_path}${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag         = filemd5("${var.website_objects_path}${each.value}")
  content_type = lookup(local.content_types, regex("\\w+$", "${var.website_objects_path}${each.value}"), "binary/octet-stream")
}
