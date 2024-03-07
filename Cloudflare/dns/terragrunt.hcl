terraform {
  source = "./"
}

# Declare variables used throughout the Terraform configuration
inputs = {
  cloudflare_api_token = get_env("CLOUDFLARE_API_TOKEN", "")
  cloudflare_zone_id   = get_env("CLOUDFLARE_ZONE_ID", "")
  cloudflare_email     = get_env("CLOUDFLARE_EMAIL", "")
  bucket_name          = get_env("AWS_BUCKET_NAME", "")
  aws_region           = get_env("AWS_REGION", "")
}
