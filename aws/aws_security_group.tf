#----------------------------------------
# セキュリティグループの作成
#----------------------------------------
resource "aws_security_group" "main" {
  name   = "${local.project}-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.project}-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "all"

  tags = {
    Name = "allow-all-traffic"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id            = aws_security_group.main.id
  referenced_security_group_id = aws_security_group.main.id
  ip_protocol                  = "all"

  tags = {
    Name = "allow-ssh-from-local"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_sakura" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "133.242.160.248/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

  tags = {
    Name = "allow-ssh-from-sakura"
  }
}
