# Define an IAM policy document that grants public read access to the S3 bucket objects
data "aws_iam_policy_document" "s3_policy" {
    depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership_controls
  ]
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.mybucket.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    effect = "Allow"
  }
}

# Apply an ACL to the bucket to make it publicly readable
resource "aws_s3_bucket_acl" "public_read_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership_controls
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

# Sets the types of public access to the bucket
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Attach the public read access policy to the bucket
resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.mybucket.id

  policy = data.aws_iam_policy_document.s3_policy.json
}