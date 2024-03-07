terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.0"
    }
  }
}

# Configure the Cloudflare provider with the necessary credentials
provider "cloudflare" {
  email   = var.cloudflare_email
  api_token = var.cloudflare_api_token
}
