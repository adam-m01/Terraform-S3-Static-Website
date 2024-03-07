# Create a DNS record in Cloudflare for the root domain pointing to the S3 bucket
resource "cloudflare_record" "my_domain" {
  allow_overwrite = "true"
  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "CNAME"
  value   = "${var.bucket_name}.s3-website.${var.aws_region}.amazonaws.com"
  ttl     = 1
  proxied = true
}

# Create a DNS record for the 'www' subdomain
resource "cloudflare_record" "www_subdomain" {
  allow_overwrite = "true"
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "CNAME"
  value   = "www.${var.bucket_name}.s3-website.${var.aws_region}.amazonaws.com"
  ttl     = 1
  proxied = true
}

