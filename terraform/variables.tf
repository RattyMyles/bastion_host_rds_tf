variable "deployment_name" {
  type = string
}

variable "region" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_username" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
  default = "11.0.0.0/16"
}

variable "instance_class" {
  type = string
  default = "db.t3.small"
}

variable "engine_version" {
  type = string
  default = "10.11.6"
}

variable "family_database" {
  type = string
  default = "mariadb10.11"
}

variable "ec2_key_pair_name" {
  type = string
  sensitive   = true
}
