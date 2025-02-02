#----------------------------------------
# VPCの作成
#----------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project}-vpc"
  }
}

#----------------------------------------
# インターネットゲートウェイの作成
#----------------------------------------
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.project}-igw"
  }
}

#----------------------------------------
# ルートテーブルの作成
#----------------------------------------
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${local.project}-rtb"
  }
}
