#----------------------------------------
# Privateサブネットの作成
#----------------------------------------
resource "aws_subnet" "private" {
  for_each = { for k, v in var.subnets : k => v if v.public == false }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${local.project}-${each.value.name}"
  }
}

resource "aws_route_table_association" "private" {
  for_each = { for k, v in var.subnets : k => v if v.public == false }

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.nat.id
}

#----------------------------------------
# NATゲートウェイの作成
#----------------------------------------
resource "aws_nat_gateway" "main" {
  subnet_id     = aws_subnet.public["${var.nat.subnet}"].id
  allocation_id = aws_eip.nat.id

  tags = {
    Name = "${local.project}-nat"
  }
}
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${local.project}-nat"
  }
}

#----------------------------------------
# NATルートテーブルの作成
#----------------------------------------
resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main.id
  }

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${local.project}-rtb-nat"
  }
}
