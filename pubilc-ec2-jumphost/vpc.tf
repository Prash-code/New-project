## VPC ##

resource "aws_vpc" "vpc_01" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "central-network"
  }
}

## IGW ##
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_01.id

  tags = {
    Name = "test-igw"
  }
}

## Public-subnet-01 ##
resource "aws_subnet" "public-web-subnet-1" {
  vpc_id = aws_vpc.vpc_01.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}
## public-subnet-2 ##
resource "aws_subnet" "public-web-subnet-2" {
  vpc_id = aws_vpc.vpc_01.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

## Create a route-table ##

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc_01.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

## Route-table-association ##

resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id = aws_subnet.public-web-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

## private-subnet-1 ##
resource "aws_subnet" "private-app-subnet-1" {
  vpc_id = aws_vpc.vpc_01.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1-App-tier"
  }
}

## private-subnet-2 ##
resource "aws_subnet" "private-app-subnet-2" {
  vpc_id = aws_vpc.vpc_01.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-2-App-tier"
  }
}

## private-subnet-1-db-1 ##

resource "aws_subnet" "private-db-subnet-1" {
  vpc_id = aws_vpc.vpc_01.id
  cidr_block = "192.168.5.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1-db-tier"
  }
}

## private-subnet-2-db-2 ##

resource "aws_subnet" "private-db-subnet-2" {
  vpc_id = aws_vpc.vpc_01.id
  cidr_block = "192.168.6.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-2-db-tier"
  }
}

## Nat-gateway ##
resource "aws_eip" "eip-nat" {
  vpc = true

  tags = {
    Name = "eip1"
  }
}
resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id = aws_subnet.public-web-subnet-2.id

  tags = {
    Name = "nat1"
  }
}