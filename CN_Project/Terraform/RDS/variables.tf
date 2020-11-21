variable "DB_USER" {
  description = "name of user"
  default     = "jonathanqa"
}

variable "DB_PASSWORD" {
  description = "password for db"
  default     = "password1234"
}
variable "subnet1_id" {
  description = "to be replaced"
}
variable "subnet2_id" {
  description = "to be replaced"
}
variable "vpc_security_group_ids" {
  description = "SG to be override"
}
