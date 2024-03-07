terraform {
  source = "./"
}

# Declare variables used throughout the Terraform configuration
inputs = {
  bucket_name = get_env("AWS_BUCKET_NAME", "")
  aws_region  = get_env("AWS_REGION", "")
  aws_access_key = get_env("AWS_ACCESS_KEY_ID", "")
  aws_secret_key = get_env("AWS_SECRET_ACCESS_KEY", "")
}
