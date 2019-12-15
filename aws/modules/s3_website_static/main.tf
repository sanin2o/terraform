resource "aws_s3_bucket" "bucket" {
  bucket = lower(var.bucket_name)

  website {
    index_document = "index.html"
  }

  tags = merge(var.common_tags, { Name = "${var.bucket_name}-bucket" })
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.bucket.id
    policy = jsonencode(
        {
          Version   = "2012-10-17",
          Statement = [
              {
                  Action    = "s3:GetObject"
                  Effect    = "Allow"
                  Principal = "*"
                  Resource  = "${aws_s3_bucket.bucket.arn}/*"
                  Sid       = "PublicReadGetObject"
              }
          ]
        }
    )
}
