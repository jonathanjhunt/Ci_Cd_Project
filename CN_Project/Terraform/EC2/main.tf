resource "aws_instance" "project_vm" {
  ami                    = var.ubuntu-ami
  instance_type          = var.instance-type
  key_name               = var.pem-key
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  lifecycle {
    create_before_destroy = true
  }

  associate_public_ip_address = var.associate_public_ip_address

  user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install python3-pip
        mkdir -p ~/.local/bin
        echo 'PATH=$PATH:~/.local/bin' >> ~/.bashrc
        source ~/.bashrc
        sudo pip3 install --user ansible
        EOF
}
