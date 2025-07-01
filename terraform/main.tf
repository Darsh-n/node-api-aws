provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  azs                  = var.azs
  project              = var.project
}

module "ecr" {
  source  = "./modules/ecr"
  project = var.project
}

module "rds" {
  source             = "./modules/rds"
  project            = var.project
  private_subnet_ids = module.vpc.private_subnet_ids
  db_username        = var.db_username
  db_password        = var.db_password
  db_sg_id           = module.security_groups.db_sg_id

  
}