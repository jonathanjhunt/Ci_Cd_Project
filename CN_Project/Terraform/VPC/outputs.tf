output "vpc_id" {
  value = aws_vpc.project_vpc.id
}

output "project_sn_id" {
  value = aws_subnet.project_sn.id
}