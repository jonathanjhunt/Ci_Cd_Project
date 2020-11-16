variable "ubuntu-ami" {
  description = "ubuntu ami ID"
  default     = "ami-0dc8d444ee2a42d8a"
}

variable "instance-type" {
  description = "machine size"
  default     = "t2.micro"
}

variable "pem-key" {
  description = "pem-key"
  default     = "JonathanQA"
}

variable "associate_public_ip_address" {
  description = "boolean true/false"
  default     = true
}
variable "subnet_id" {
  description = "subnet ID"
}
variable "vpc_security_group_ids" {
  description = "SG to be override"
}

variable "tags" {
  description = "to be override"
}
