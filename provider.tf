provider "aws" {
  profile    = "default"
  region     = var.provider_region
  access_key = var.secret_access_key
  secret_key = var.secret_key
}
