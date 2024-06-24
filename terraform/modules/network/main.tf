resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.deployment_name
    Billing = var.deployment_name
  }
}

data "aws_availability_zones" "available" {}


## Subnets
resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 0)
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.deployment_name}-public-a"
    Billing = var.deployment_name
  }
}

resource "aws_subnet" "private_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 2)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.deployment_name}-private-a"
    Billing = var.deployment_name
  }
}

resource "aws_subnet" "private_b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 3)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.deployment_name}-private-b"
    Billing = var.deployment_name
  }
}

## Internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id =  aws_vpc.vpc.id
  tags = {
    Name = "${var.deployment_name}-igw"
    Billing = var.deployment_name
  }
}

resource "aws_route_table" "public_route_table"{
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.deployment_name}-public"
    Billing = var.deployment_name
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_a" {
  subnet_id =  aws_subnet.public_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table"{
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.deployment_name}-private"
    Billing = var.deployment_name
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id =  aws_subnet.private_a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id =  aws_subnet.private_b.id
  route_table_id = aws_route_table.private_route_table.id
}