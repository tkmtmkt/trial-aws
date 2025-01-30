#----------------------------------------
# EC2インスタンスの作成
#----------------------------------------
resource "aws_instance" "example_app1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.example_main_private.id
  private_ip    = var.main_private.private_ip_app1
  key_name      = aws_key_pair.example.id

  user_data = <<EOF
#! /bin/bash
sudo snap install docker
sudo snap install --classic powershell
sudo groupadd docker
sudo usermod -aG docker ubuntu
EOF

  tags = {
    Name = "${var.project}-app1"
  }
}

#----------------------------------------
# インスタンスを停止状態にする
#----------------------------------------
resource "aws_ec2_instance_state" "example_app1" {
  instance_id = aws_instance.example_app1.id
  state       = "stopped"
}
