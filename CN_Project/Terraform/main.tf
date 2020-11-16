provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
}

module "aws_vpc" {
  source = "./VPC"
}

module "aws_webserver_sg" {
  source = "./SecurityGroups"
  name   = "WebServerSG"
  vpc_id = aws_vpc.project_vpc.id
}

module "webserver_node" {
  source                 = "./EC2"
  subnet_id              = aws_subnet.project_sn.id
  vpc_security_group_ids = aws_security_group.project_sg.id
  tags = {
    Name = "WebServer_Node"
  }
  associate_public_ip_address = true
}
