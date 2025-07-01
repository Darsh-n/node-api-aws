variable "region" {}
variable "project" {}
variable "instance_type" { default = "t3.micro" }
variable "account_id" {}
variable "ecr_repo_url" {}
variable "instance_profile_name" {}
variable "target_group_arn" {}
variable "public_subnet_ids" {}