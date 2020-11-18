variable "vpc-cidr-block" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "project_sn-cidr-block" {
  description = "CIDR block for Public Subnet A"
  default     = "10.0.1.0/24"
}

variable "project_sn2-cidr-block" {
  description = "CIDR block for Public Subnet A"
  default     = "10.0.2.0/24"
}
