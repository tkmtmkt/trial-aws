#----------------------------------------
# キーペア作成
#----------------------------------------
resource "aws_key_pair" "main" {
  key_name   = "${local.project}.id_ed25519"
  public_key = tls_private_key.keygen.public_key_openssh
}

resource "tls_private_key" "keygen" {
  algorithm = "ED25519"
}

#----------------------------------------
# キーペアファイル保存
#----------------------------------------
locals {
  private_key_file = "./.ssh/${local.project}.id_ed25519"
  public_key_file  = "./.ssh/${local.project}.id_ed25519.pub"
}

resource "local_file" "private_key_file" {
  filename = local.private_key_file
  content  = tls_private_key.keygen.private_key_openssh
  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_file}"
  }
}

resource "local_file" "public_key_file" {
  filename = local.public_key_file
  content  = tls_private_key.keygen.public_key_openssh
  provisioner "local-exec" {
    command = "chmod 600 ${local.public_key_file}"
  }
}
