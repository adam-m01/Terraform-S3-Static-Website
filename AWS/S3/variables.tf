variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy S3 resources in"
  type        = string
  default     = "eu-west-2"
}

variable "aws_access_key" {
  description = "The AWS IAM access key"
  type        = string
}

variable "aws_secret_key" {
  description = "The AWS IAM secret key"
  type        = string
}