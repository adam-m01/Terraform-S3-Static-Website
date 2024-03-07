variable "cloudflare_api_token" {
  description = "API Token for Cloudflare"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Zone ID for Cloudflare"
  type        = string
}

variable "cloudflare_email" {
  description = "Email of the Cloudflare account"
  type        = string
}


variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy S3 resources in"
  type        = string
  default     = "eu-west-2"
}
