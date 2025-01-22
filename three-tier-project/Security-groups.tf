## SG for Application load balance ##

resource "aws_security_group" "alb-security-group" {
  name = "ALB Security Group"
  description = "Enable http/https access on port 80/443"
  vpc_id = aws_vpc.vpc_01.id
  depends_on = [ aws_vpc.vpc_01 ]

  ingress {
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "http access"
    from_port = 80
    to_port   = 80
    protocol =  "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "https access"
    from_port = 443
    to_port   = 443
    protocol =  "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name = "ALB Security Group"
  }
}

## SG for app-tier (bastion host) ##
resource "aws_security_group" "ssh-security-group" {
  name = "SSH Access"
  description = "enable ssh access on port 22"
  vpc_id = aws_vpc.vpc_01.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp" 
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "ssh security group"
  }
}

## SG presentation-tier ##

resource "aws_security_group" "webserver-security-group" {
  name = "web-security-group"
  description = "enable http/https access on port 80/443 via ALB and SSH via sg"
  vpc_id = aws_vpc.vpc_01.id

  ingress {
    description = "http access"
    from_port = 80
    to_port   = 80
    protocol =  "tcp"
    security_groups = ["${aws_security_group.alb-security-group.id}"]
  }

    ingress {
    description = "https access"
    from_port = 443
    to_port   = 443
    protocol =  "tcp"
    security_groups = ["${aws_security_group.alb-security-group.id}"]
  }

  ingress {
    description = "ssh access"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.alb-security-group.id}"]
  }

  egress  {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
}

tags = {
  Name = "web server security group"
}
}
