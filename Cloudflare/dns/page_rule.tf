# Create a Cloudflare page rule to enforce HTTPS redirection
resource "cloudflare_page_rule" "http_to_https" {
  zone_id  = var.cloudflare_zone_id
  target   = "${var.bucket_name}/*"
  priority = 1
  status   = "active"
  actions {
    always_use_https = true
  }
}

# Override SSL configuration type
resource "cloudflare_zone_settings_override" "my_zone_settings" {
  zone_id = var.cloudflare_zone_id

  settings {
    ssl = "flexible"
  }
}
