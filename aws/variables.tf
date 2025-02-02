locals {
  project = "example"
  region  = "ap-northeast-1"
}

# VPC
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# Endpoint
variable "endpoint" {
  type = map(any)
  default = {
    subnet = "main_public"
  }
}

# Subnet
variable "subnets" {
  type = map(any)
  default = {
    main_public = {
      name   = "main-public",
      cidr   = "10.0.1.0/24",
      az     = "ap-northeast-1a"
      public = true
    },
    main_private = {
      name   = "main-private",
      cidr   = "10.0.3.0/24",
      az     = "ap-northeast-1a"
      public = false
    },
    backup_public = {
      name   = "backup-public",
      cidr   = "10.0.2.0/24",
      az     = "ap-northeast-1c"
      public = true
    },
    backup_private = {
      name   = "backup-private",
      cidr   = "10.0.4.0/24",
      az     = "ap-northeast-1c"
      public = false
    }
  }
}

# EC2
variable "hosts" {
  type = map(any)
  default = {
    web1 = {
      instance_type = "t3.micro"
      subnet        = "main_public"
      private_ip    = "10.0.1.10"
    }
    app1 = {
      instance_type = "t3.micro"
      subnet        = "main_private"
      private_ip    = "10.0.3.10"
    }
    web2 = {
      instance_type = "t3.micro"
      subnet        = "backup_public"
      private_ip    = "10.0.2.10"
    }
    app2 = {
      instance_type = "t3.micro"
      subnet        = "backup_private"
      private_ip    = "10.0.4.10"
    }
  }
}
