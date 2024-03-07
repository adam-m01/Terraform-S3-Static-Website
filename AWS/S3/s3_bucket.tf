# Create the main S3 bucket to host the website content
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name
}

# Create a secondary S3 bucket to handle 'www' redirection
resource "aws_s3_bucket" "www_redirect_bucket" {
  bucket = "www.${var.bucket_name}"
}

# Configure the 'www' redirect bucket to redirect all requests to the main bucket
resource "aws_s3_bucket_website_configuration" "www_redirect_website" {
  bucket = aws_s3_bucket.www_redirect_bucket.id

  redirect_all_requests_to {
    host_name = var.bucket_name
    protocol  = "https"
  }
}

# Set ownership controls on the main bucket to define how objects are owned
resource "aws_s3_bucket_ownership_controls" "bucket_ownership_controls" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Configure the main bucket to serve a website with an index document
resource "aws_s3_bucket_website_configuration" "hosting" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }
}
