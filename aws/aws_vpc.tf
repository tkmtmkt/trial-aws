#----------------------------------------
# VPCの作成
#----------------------------------------
resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-vpc"
  }
}

#----------------------------------------
# インターネットゲートウェイの作成
#----------------------------------------
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "${var.project}-igw"
  }
}

#----------------------------------------
# ルートテーブルの作成
#----------------------------------------
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "${var.project}-rtb"
  }
}

#----------------------------------------
# セキュリティグループの作成
#----------------------------------------
resource "aws_security_group" "example" {
  name   = "${var.project}-sec"
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "${var.project}-sec"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  description       = "allow all traffic"
  security_group_id = aws_security_group.example.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name = "allow_all_traffic"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_sakura" {
  description       = "allow ssh from sakura"
  security_group_id = aws_security_group.example.id
  cidr_ipv4         = "133.242.160.248/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

  tags = {
    Name = "allow_ssh_from_sakura"
  }
}
