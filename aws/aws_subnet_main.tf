#----------------------------------------
# サブネット: main_public
#----------------------------------------
resource "aws_subnet" "example_main_public" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = var.main_public.cidr_block
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-main-public"
  }
}

resource "aws_route_table_association" "example_public_1a" {
  subnet_id      = aws_subnet.example_main_public.id
  route_table_id = aws_route_table.example.id
}

#----------------------------------------
# サブネット: main_private
#----------------------------------------
resource "aws_subnet" "example_main_private" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = var.main_private.cidr_block
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.project}-main-private"
  }
}
