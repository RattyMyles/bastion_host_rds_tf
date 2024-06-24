resource "aws_db_instance" "database" {
  allow_major_version_upgrade = false
  apply_immediately = true
  backup_retention_period = 3
  vpc_security_group_ids = [var.database_sg.id]
  db_subnet_group_name = aws_db_subnet_group.database.name
  engine = "mariadb"
  engine_version = var.engine_version
  username = var.db_username
  password = var.db_password
  parameter_group_name = aws_db_parameter_group.database.name
  allocated_storage = 20
  instance_class = var.instance_class
  skip_final_snapshot = true
  publicly_accessible = false
  port = 3306
  tags = {
    Billing : var.deployment_name,
    Name: "${var.deployment_name}-mariadb"
    db_reporting_enabled: true
  }
}


resource "aws_db_subnet_group" "database" {
  name = "${var.deployment_name}-subnet_group"
  subnet_ids = [
  var.subnet_database_a.id, var.subnet_database_b.id]
  tags = {
    Billing = var.deployment_name
  }
}

resource "aws_db_parameter_group" "database" {
  family = var.family_database
  name = "${var.deployment_name}-pg"

  parameter {
    name         = "lower_case_table_names"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "sql_mode"
    value        = "NO_AUTO_VALUE_ON_ZERO"
    apply_method = "pending-reboot"
  }
  tags = {
    Billing = var.deployment_name
  }
}