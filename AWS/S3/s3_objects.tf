# Define local MIME types for file extensions
locals {
  mime_types = {
    "css"   = "text/css",
    "html"  = "text/html",
    "webp"  = "image/webp",
    "js"    = "application/javascript",
    "ico"   = "image/vnd.microsoft.icon",
    "ttf"   = "font/ttf",
    "woff2" = "font/woff2",
    "woff"  = "font/woff",
    "gif"   = "image/gif",
    "svg"   = "image/svg+xml",
    "eot"   = "application/vnd.ms-fontobject"
  }
}

# Upload files to the S3 bucket
resource "aws_s3_object" "s3_objects" {
  for_each = fileset("${path.module}/website", "**/*")

  bucket       = aws_s3_bucket.mybucket.id
  key          = each.key
  source       = "${path.module}/website/${each.key}"
  content_type = lookup(local.mime_types, element(split(".", each.key), length(split(".", each.key)) - 1), "binary/octet-stream")
  etag         = filemd5("${path.module}/website/${each.key}")
}
