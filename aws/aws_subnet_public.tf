#----------------------------------------
# Publicサブネットの作成
#----------------------------------------
resource "aws_subnet" "public" {
  for_each = { for k, v in var.subnets : k => v if v.public == true }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.public

  tags = {
    Name = "${local.project}-${each.value.name}"
  }
}

resource "aws_route_table_association" "public" {
  for_each = { for k, v in var.subnets : k => v if v.public == true }

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_default_route_table.igw.id
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
resource "aws_default_route_table" "igw" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${local.project}-rtb-igw"
  }
}
