resource "aws_security_group" "bastion_sg" {
  name        = "${var.deployment_name}-bastion-sg"
  description = "Security group for ${var.deployment_name} bastion host"
  vpc_id      = var.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "${var.deployment_name}-bastion-sg"
    Project = var.deployment_name
  }
}

resource "aws_security_group" "database_sg" {
  name        = "${var.deployment_name}-database-sg"
  description = "Security group for ${var.deployment_name} database"
  vpc_id      = var.vpc.id

  tags = {
    Name    = "${var.deployment_name}-database-sg"
    Project = var.deployment_name
  }
}

resource "aws_security_group_rule" "bastion_sg"{
  from_port = 3306
  protocol  = "tcp"
  to_port   = 3306
  security_group_id = aws_security_group.database_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
  type = "ingress"
}
