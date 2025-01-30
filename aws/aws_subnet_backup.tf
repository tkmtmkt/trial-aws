#----------------------------------------
# サブネット: backup_public
#----------------------------------------
resource "aws_subnet" "example_backup_public" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = var.backup_public.cidr_block
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-backup-public"
  }
}

resource "aws_route_table_association" "example_backup_public" {
  subnet_id      = aws_subnet.example_backup_public.id
  route_table_id = aws_route_table.example.id
}

#----------------------------------------
# サブネット: backup_private
#----------------------------------------
resource "aws_subnet" "example_backup_private" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = var.backup_private.cidr_block
  availability_zone = "${var.region}c"

  tags = {
    Name = "${var.project}-backup-private"
  }
}
