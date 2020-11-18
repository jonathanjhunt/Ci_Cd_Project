resource "aws_db_instance" "project_live" {
  allocated_storage    = "20"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "projectDB_live"
  username             = var.DB_USER
  password             = var.DB_PASSWORD
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.db_group.name
}

resource "aws_db_instance" "project_test" {
  allocated_storage    = "20"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "projectDB_test"
  username             = var.DB_USER
  password             = var.DB_PASSWORD
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.db_group.name
}
resource "aws_db_subnet_group" "db_group" {
  name       = "db_group"
  subnet_ids = [var.subnet1_id, var.subnet2_id]

  tags = {
    Name = "db_group"
  }
}
