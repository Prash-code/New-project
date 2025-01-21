#create VPC
resource "aws_vpc" "prash" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "mumbai-vpc"
  }
}
#create internet gateway and attach vpc
resource "aws_internet_gateway" "prash" {
  vpc_id = aws_vpc.prash.id
  tags = {
    Name = "mumbai-IGW"
  }
}
#create subnet
resource "aws_subnet" "prash" {
  vpc_id = aws_vpc.prash.id
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "mumbai-subnet"
  }
}
#create route tables and attach IGW to RT
resource "aws_route_table" "prash" {
  vpc_id = aws_vpc.prash.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prash.id
    
  }
  
}
#subnet association
resource "aws_route_table_association" "prash" {
  route_table_id = aws_route_table.prash.id
  subnet_id = aws_subnet.prash.id
}
#create SG
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.prash.id
  tags = {
    Name = "mumbai-SG"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


  }