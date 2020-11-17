variable "ubuntu-ami" {
  description = "ubuntu ami ID"
  default     = "ami-0dc8d444ee2a42d8a"
}

variable "instance-type" {
  description = "ubuntu ami ID"
  default     = "ami-0dc8d444ee2a42d8a"
}

variable "pem-key" {
  description = "pem-key"
  default     = "JonathanQA"
}

variable "associate_public_ip_address" {
  description = "boolean true/false"
  default     = true
}
