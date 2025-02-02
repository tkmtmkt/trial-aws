#----------------------------------------
# サブネットの作成
#----------------------------------------
resource "aws_subnet" "main" {
  for_each = var.subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  #map_public_ip_on_launch = each.value.public

  tags = {
    Name = "${local.project}-${each.value.name}"
  }
}

resource "aws_route_table_association" "main" {
  for_each = var.subnets

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main.id
}
