#----------------------------------------
# EC2インスタンスエンドポイントの作成
#----------------------------------------
resource "aws_ec2_instance_connect_endpoint" "main" {
  subnet_id = aws_subnet.public["${var.endpoint.subnet}"].id
  security_group_ids = [
    aws_security_group.main.id,
  ]

  tags = {
    Name = "${local.project}-endpoint"
  }
}
