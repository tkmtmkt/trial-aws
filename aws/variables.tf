variable "project" {
  type    = string
  default = "example"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "main_public" {
  default = {
    cidr_block      = "10.0.1.0/24"
    private_ip_web1 = "10.0.1.101"
  }
}

variable "main_private" {
  default = {
    cidr_block      = "10.0.3.0/24"
    private_ip_app1 = "10.0.3.101"
  }
}

variable "backup_public" {
  default = {
    cidr_block      = "10.0.2.0/24"
    private_ip_web2 = "10.0.2.101"
  }
}

variable "backup_private" {
  default = {
    cidr_block      = "10.0.4.0/24"
    private_ip_app2 = "10.0.4.101"
  }
}
