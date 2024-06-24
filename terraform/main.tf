provider "aws" {
  version = "~> 2.7"
  region = var.region
}


module "network" {
  source = "./modules/network"
  deployment_name = var.deployment_name
  vpc_cidr        = var.vpc_cidr_block
}

module "security_groups" {
  source = "./modules/security_groups"
  deployment_name = var.deployment_name
  vpc             = module.network.vpc
}

module "rds" {
  source = "./modules/rds"

  database_sg       = module.security_groups.database_sg
  db_password       = var.db_password
  db_username       = var.db_username
  deployment_name   = var.deployment_name
  engine_version    = var.engine_version
  family_database   = var.family_database
  instance_class    = var.instance_class
  subnet_database_a = module.network.subnet_private_a
  subnet_database_b = module.network.subnet_private_b
}

module "ec2" {
  source = "./modules/ec2"
  bastion_host_sg   = module.security_groups.bastion_host_sg
  ec2_key_pair_name = var.ec2_key_pair_name
  subnet_public_a   = module.network.subnet_public_a
}