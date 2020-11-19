variable "ingress_ports" {
  type        = list(number)
  description = "List of ingress ports"
  default     = [22, 80, 443, 3306, 8080, 5000, 5001]
}

variable "name" {
  description = "name of security group"
  default     = "project_sg"
}

variable "outbound-port" {
  description = "outbound port"
  default     = "0"
}

variable "open-internet" {
  description = "open IP "
  default     = ["0.0.0.0/0"]
}

variable "vpc_id" {
  description = "aws_vpc.project_vpc.id"
}
