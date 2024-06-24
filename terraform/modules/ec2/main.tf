data "aws_ami" "latest_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.latest_ami.id
  instance_type = "t2.micro"
  subnet_id = var.subnet_public_a.id
  vpc_security_group_ids = [var.bastion_host_sg.id]
  key_name = var.ec2_key_pair_name
}