resource "aws_instance" "project_vm" {
  ami                    = var.ubuntu-ami
  instance_type          = var.instance-type
  key_name               = var.pem-key
  subnet_id              = aws_subnet.project_sn.id
  vpc_security_group_ids = aws_security_group.project_sg.id

  lifecycle {
    create_before_destroy = true
  }

  associate_public_ip_address = var.associate_public_ip_address

}
