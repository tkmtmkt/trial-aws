#----------------------------------------
# VPCの作成
#----------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project}-vpc"
  }
}
