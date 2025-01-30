#----------------------------------------
# EC2インスタンスの作成
#----------------------------------------
resource "aws_instance" "example_web2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.example_backup_public.id
  private_ip             = var.backup_public.private_ip_web2
  vpc_security_group_ids = [aws_security_group.example.id]
  key_name               = aws_key_pair.example.id

  user_data = <<EOF
#! /bin/bash
sudo snap install docker
sudo snap install --classic powershell
sudo groupadd docker
sudo usermod -aG docker ubuntu
EOF

  tags = {
    Name = "${var.project}-web2"
  }
}

#----------------------------------------
# インスタンスを停止状態にする
#----------------------------------------
resource "aws_ec2_instance_state" "example_web2" {
  instance_id = aws_instance.example_web2.id
  state       = "stopped"
}
