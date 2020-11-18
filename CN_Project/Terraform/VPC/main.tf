resource "aws_vpc" "project_vpc" {
  cidr_block = var.vpc-cidr-block
  tags = {
    Name = "production"
  }

}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "project_sn" {
  cidr_block        = var.project_sn-cidr-block
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.project_vpc.id
}

resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name = "VPC Internet Gateway"
  }

}

resource "aws_route_table" "project_rt" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_igw.id
  }

  tags = {
    Name = "Route Table for VPC"
  }
}

resource "aws_route_table_association" "project_rta" {
  subnet_id      = aws_subnet.project_sn.id
  route_table_id = aws_route_table.project_rt.id
}

