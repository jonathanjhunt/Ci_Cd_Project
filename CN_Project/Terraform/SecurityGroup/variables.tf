variable "ingress_ports" {
  type        = list(number)
  description = "List of ingress ports"
  default     = [22, 80, 443, 3306]
}

variable "name" {
    description = "name of security group"
    default = "project_sg"
}

variable "outbound_port" {
  description = "outbound port"
  default     = "0"
}

variable "open-internet {
  description = "open IP "
  default     = ["0.0.0.0/0"]
}