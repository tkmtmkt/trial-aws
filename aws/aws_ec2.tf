#----------------------------------------
# EC2インスタンスの作成
#----------------------------------------
resource "aws_instance" "public" {
  for_each = { for k, v in var.hosts : k => v if v.public == true }

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = each.value.instance_type
  subnet_id              = aws_subnet.public[each.value.subnet].id
  private_ip             = each.value.private_ip
  key_name               = aws_key_pair.main.id
  vpc_security_group_ids = [aws_security_group.main.id]

  user_data = <<EOF
#! /bin/bash
sudo snap install docker
sudo groupadd docker
sudo usermod -aG docker ubuntu
EOF

  tags = {
    Name = "${local.project}-${each.key}"
  }
}

resource "aws_instance" "private" {
  for_each = { for k, v in var.hosts : k => v if v.public == false }

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = each.value.instance_type
  subnet_id              = aws_subnet.private[each.value.subnet].id
  private_ip             = each.value.private_ip
  key_name               = aws_key_pair.main.id
  vpc_security_group_ids = [aws_security_group.main.id]

  user_data = <<EOF
#! /bin/bash
sudo snap install docker
sudo groupadd docker
sudo usermod -aG docker ubuntu
EOF

  tags = {
    Name = "${local.project}-${each.key}"
  }
}
