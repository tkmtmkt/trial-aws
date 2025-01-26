# provider variables
variable "provider_region" {
  description = "Provider region"
  default     = "ap-northeast-1"
}

variable "secret_access_key" {
  description = "Provider access key"
  default     = "YOUR-ACCESS-KEY"
}

variable "secret_key" {
  description = "Provider secret key"
  default     = "YOUR-SECRET-KEY"
}

# instance web variables
variable "server_instance_type" {
  description = "Server instance type"
  default     = "t2.micro"
}

variable "server_tag_name" {
  description = "Server tag name"
  default     = "JeSuisUnDev"
}
