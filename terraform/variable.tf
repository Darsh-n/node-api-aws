variable "region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "task-api"
}

variable "db_username" {
  sensitive = true
}

variable "db_password" {
  sensitive = true
}

variable "db_name" {
  default = "tasks_db"
}

variable "allowed_ssh_cidr" {
  default = "0.0.0.0/0" # Replace with your IP for security
}


#cloud Watch
variable "alert_email" {
  default = "dahakedarshan99@gmail.com"
}