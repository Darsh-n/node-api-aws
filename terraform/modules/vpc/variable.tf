variable "vpc_cidr" {}
variable "public_subnet_cidrs" { type = list(string) }
variable "azs" { type = list(string) }
variable "project" {}