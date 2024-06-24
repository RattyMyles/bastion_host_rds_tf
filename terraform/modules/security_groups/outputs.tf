output "bastion_host_sg" {
  value = aws_security_group.bastion_sg
}

output "database_sg" {
  value = aws_security_group.database_sg
}