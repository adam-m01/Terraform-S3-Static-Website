# Static Website Deployment with Terraform/Terragrunt for AWS S3 and Cloudflare Integration

![Banner](https://github.com/adam-m01/Terraform-S3-Static-Website/assets/7604430/1ef61ab7-4200-43f7-8924-0eea4ab5e5a7)


This repository provides Terraform and Terragrunt configurations tailored for deploying static websites seamlessly on AWS S3 while leveraging Cloudflare for DNS management and SSL/TLS encryption.


## Table of Contents

- [Static Website Deployment with AWS S3 and Cloudflare](#static-website-deployment-with-aws-s3-and-cloudflare)
  - [Prerequisites](#prerequisites)
  - [Directory Structure](#directory-structure)
  - [Initial Setup](#initial-setup)
    - [Clone the Repository](#clone-the-repository)
    - [Acquiring Environment Variables](#acquiring-environment-variables)
      - [AWS IAM User Setup](#aws-iam-user-setup)
      - [Cloudflare Setup for API Token and Zone ID](#cloudflare-setup-for-api-token-and-zone-id)
    - [Setting Environment Variables](#setting-environment-variables)
  - [Website Deployment](#website-deployment)
    - [Prepare Static Files](#prepare-static-files)
    - [Initialize & Apply Configuration](#initialize--apply-configuration)
## Prerequisites

Before starting, ensure you have the following:
- An AWS account with access to S3 | Sign up or log in [here](https://aws.amazon.com/)
- A Cloudflare account and a configured domain | Sign up or manage your domains [here](https://www.cloudflare.com/)
- Git, for cloning the repository | Download it [here](https://git-scm.com/downloads).
- Terraform (version >= 0.12) | Installation instructions are available [here](https://developer.hashicorp.com/terraform/install)
- Terragrunt, for simplified Terraform workflow | Learn how to install it [here](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- A shell environment like PowerShell for Windows users or Bash for Linux/macOS users

## Directory Structure

```plaintext
Directory Structure
├── AWS_S3 
│   ├── website 
│   │   └── add_static_web_files_here 
│   ├── s3_bucket.tf          # S3 bucket configuration 
│   ├── provider.tf           # AWS provider configuration 
│   ├── s3_objects.tf         # S3 objects upload configuration 
│   ├── s3_policy.tf          # S3 bucket policies 
│   ├── terragrunt.hcl        # Terragrunt configuration for S3 
│   └── variables.tf          # Variable definitions for S3 
└── Cloudflare_dns 
    ├── dns.tf                # Cloudflare DNS records configuration 
    ├── page_rule.tf          # Cloudflare page rules configuration 
    ├── provider.tf           # Cloudflare provider configuration 
    ├── terragrunt.hcl        # Terragrunt configuration for Cloudflare 
    └── variables.tf          # Variable definitions for Cloudflare

```
Each `.tf` file contains Terraform configurations for setting up different parts of the infrastructure. The `terragrunt.hcl` files are used to apply the configurations with Terragrunt.

## Initial Setup
### Clone the Repository

```sh
git clone https://github.com/adam-m01/Terraform-S3-Static-Website.git
cd Terraform-S3-Static-Website
```

This will create a directory named `terraform-s3-static-website` in your current working directory.

### Acquiring Environment Variables

You will need to set the following environment variables in your shell:

```sh
AWS_BUCKET_NAME: The name of your AWS S3 bucket
AWS_REGION: Your preferred AWS region (e.g., eu-west-2)
AWS_ACCESS_KEY_ID: Your AWS access key
AWS_SECRET_ACCESS_KEY: Your AWS secret access key
CLOUDFLARE_API_TOKEN: Your Cloudflare API token
CLOUDFLARE_EMAIL: The email associated with your Cloudflare account
CLOUDFLARE_ZONE_ID: Your Cloudflare zone ID
```
The variables can be attained by following the steps below

### AWS IAM User Setup

***It is important to create an IAM user rather than using your AWS account's root user***

1. **Login to AWS Console**: Go to the AWS Management Console and log in.
2. **Navigate to IAM**: Search for and select IAM. Go to "Users" → "Create User".
3. **Create User**: Provide a username and proceed.
4. **Assign Permissions**: Assign the "AdministratorAccess" policy for full AWS account management capabilities.
5. **Finalize User Creation**: Click "Next" and "Create User".
6. **Generate Access Keys**:
    - After creation, find the user under "Users".
    - Select "Security credentials" tab.
    - Under "Access keys", click "Create access key".
    - Choose the "CLI" option and confirm.
7. **Securely Store Keys**: Save the Access Key ID and Secret Access Key securely.

### Cloudflare Setup for API Token and Zone ID

1. **Log In to Cloudflare**: Open the Cloudflare dashboard and sign in.
2. **Create API Token**: Go to `Account` > `My Profile` > `API Tokens` > `Create Token` > `Create Custom Token`.
3. **Name Your Token**: Enter a name for the token, such as "Edit Zone".
4. **Configure Permissions**: Set the following permissions for the token:
    - **Zone**: `Zone Settings` - `Edit`
    - **Zone**: `Zone` - `Read`
    - **Zone**: `Page Rules` - `Edit`
    - **Zone**: `DNS` - `Edit`
   Each permission should be applied to the "Zone" level for precise control.
6. **Create Token**: Click the button to create your token.
7. **Securely Store Token**: Save the Cloudflare token securely.
8. **Obtain Zone ID**: 
   - Select the relevant domain from the dashboard.
   - Click on the `Overview` tab.
   - Locate the Zone ID in the API section on the right-hand panel.
   - Record the Zone ID securely.

## Environment Variables
### Setting Environment Variables

Environment variables can be set in the terminal using `$env:` for PowerShell (Windows) or `export` for Bash (Linux/macOS). 

Replace the placeholder text with your actual credentials.

The `AWS_BUCKET_NAME` should match the domain name configured in Cloudflare, excluding 'www' or any other subdomains. e.g. `example.com`

**PowerShell (Windows):**
```powershell
$env:AWS_BUCKET_NAME="your_bucket_name"
$env:AWS_REGION="your_aws_region"
$env:AWS_ACCESS_KEY_ID="your_aws_access_key_id"
$env:AWS_SECRET_ACCESS_KEY="your_aws_secret_access_key"
$env:CLOUDFLARE_API_TOKEN="your_cloudflare_api_token"
$env:CLOUDFLARE_EMAIL="your_cloudflare_email"
$env:CLOUDFLARE_ZONE_ID="your_cloudflare_zone_id"
```
**Bash (Linux/macOS):**

```bash
export AWS_BUCKET_NAME="your_bucket_name"
export AWS_REGION="your_aws_region"
export AWS_ACCESS_KEY_ID="your_aws_access_key_id"
export AWS_SECRET_ACCESS_KEY="your_aws_secret_access_key"
export CLOUDFLARE_API_TOKEN="your_cloudflare_api_token"
export CLOUDFLARE_EMAIL="your_cloudflare_email"
export CLOUDFLARE_ZONE_ID="your_cloudflare_zone_id"
```
## Website Deployment
### Prepare Static Files

Place all your static website files into the `website` folder located at `AWS/S3/website`. This is where Terraform will look for files to upload to the S3 bucket.


### Initialize & Apply Configuration
In the root directory, initialize and apply the configuration
```sh
terragrunt run-all init   # Initializes the configuration
terragrunt run-all plan   # (Optional) Previews the changes
terragrunt run-all apply  # Applies the configuration
```
Once the configuration has been applied the live website can be viewed on your domain name.


To remove all deployed resources:
```sh
terragrunt run-all destroy  # Removes all resources
```
